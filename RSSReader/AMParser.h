//
//  AMGetAndParseRSS.h
//  RSSReader
//
//  Created by Gansta_les on 21.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AMParserDelegate <NSObject>
@required
- (void)endLoading;
- (void)failedWithError:(NSError*)error;
@end

@interface AMParser : NSObject

@property (weak) id<AMParserDelegate> delegate;

+ (AMParser *)sharedInstance;
- (void)getAndParseRSS;

@end
