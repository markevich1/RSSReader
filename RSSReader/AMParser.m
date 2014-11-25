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
                                                  @"media:thumbnail.url" : @"media",
                                                  @"pubDate.text" : @"pubDate"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:nil
                                                                                           keyPath:@"rss.channel.item"
                                                                                       statusCodes:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://people.onliner.by/feed"]];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        [[AMDatabaseManager sharedInstance] saveNewsArrayToDatabase:[result array]];
        if ([self.delegate respondsToSelector:@selector(showNewsArrayScreen)]) {
            [self.delegate showNewsArrayScreen];
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
           [self failedWithError:error];
            [self.delegate showNewsArrayScreen];
        });
        
    }];
    [operation start];
}

- (void)failedWithError:(NSError*)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error"
                                                    message:[error localizedDescription]
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
