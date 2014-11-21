//
//  AMGetAndParseRSS.h
//  RSSReader
//
//  Created by Gansta_les on 21.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMParser : NSObject

+ (AMParser *)sharedInstance;
- (void)getAndParseRSS;

@end
