//
//  AMNews.h
//  RSSReader
//
//  Created by Gansta_les on 20.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMNews : NSObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * pubDate;
@property (nonatomic, retain) NSString * media;

-(void)saveNewsToDatabase;

@end
