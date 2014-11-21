//
//  AMGetAndParseRSS.m
//  RSSReader
//
//  Created by Gansta_les on 21.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import "AMParser.h"
#import <RKXMLReaderSerialization.h>
#import <RestKit/RestKit.h>
#import "AMNews.h"
#import "AMDatabaseManager.h"

@implementation AMParser

+ (AMParser *)sharedInstance
{
    static AMParser *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AMParser alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
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
        [[AMDatabaseManager sharedInstance] saveNewsArrayToDatabase:[result array]];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
    }];
    [operation start];
}

@end
