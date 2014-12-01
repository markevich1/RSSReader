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

static NSString * const mimeTypeString = @"text/xml";
static NSString * const itemKeyPath = @"rss.channel.item";
static NSString * const feedURLString = @"http://people.onliner.by/feed";
static NSString * const titleKey = @"title.text";
static NSString * const titleValue = @"title";
static NSString * const linkKey = @"link.text";
static NSString * const linkValue = @"link";
static NSString * const mediaKey = @"media:thumbnail.url";
static NSString * const mediaValue = @"media";
static NSString * const pubDateKey = @"pubDate.text";
static NSString * const pubDateValue = @"pubDate";

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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

    
    [RKMIMETypeSerialization registerClass:[RKXMLReaderSerialization class] forMIMEType:mimeTypeString];
    
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[AMNews class]];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  titleKey : titleValue,
                                                  linkKey : linkValue,
                                                  mediaKey : mediaValue,
                                                  pubDateKey : pubDateValue
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                            method:RKRequestMethodGET pathPattern:nil
                                                                                           keyPath:itemKeyPath
                                                                                       statusCodes:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:feedURLString]];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        [[AMDatabaseManager sharedInstance] saveNewsArrayToDatabase:[result array]];
        if ([self.delegate respondsToSelector:@selector(showNewsArrayScreen)]) {
            [self.delegate showNewsArrayScreen];
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if ([self.delegate respondsToSelector:@selector(failedWithError:)]) {
                [self.delegate failedWithError:error];
            }
            [self.delegate showNewsArrayScreen];
        });
        
    }];
    [operation start];
        
        });
}


@end
