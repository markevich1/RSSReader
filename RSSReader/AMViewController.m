//
//  AMViewController.m
//  RSSReader
//
//  Created by Gansta_les on 19.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import "AMViewController.h"
#import "News.h"
#import <RKXMLReaderSerialization.h>
#import <RestKit/RestKit.h>
#import "AMNews.h"

@interface AMViewController ()

@end

@implementation AMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self getAndParseRSS];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAndParseRSS
{
    [RKMIMETypeSerialization registerClass:[RKXMLReaderSerialization class] forMIMEType:@"application/rss+xml"];
    
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[AMNews class]];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                       @"title.text" : @"title",
                                                       @"link.text" : @"link",
                                                       @"media:content.url" : @"media",
                                                       @"pubDate.text" : @"pubDate"
                                                       }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:nil
                                                                                           keyPath:@"rss.channel.item"
                                                                                       statusCodes:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://news.tut.by/rss/all.rss"]];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        [self saveNewsArrayToDatabase:[result array]];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
    }];
    [operation start];
}

-(void)saveNewsArrayToDatabase:(NSArray*)newsArray
{
    [News MR_truncateAll];
    for(AMNews *news in newsArray){
        [news saveNewsToDatabase];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
/*
    NSArray *Array = [News MR_findAll];
    for (News* news in Array) {
        NSLog(@"\ntitle:%@\nlink:%@\npubDate:%@\nmedia:%@",news.title, news.link, news.pubDate, news.media);
    }
*/
}
@end
