//
//  News.h
//  RSSReader
//
//  Created by Gansta_les on 19.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface News : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * pubDate;
@property (nonatomic, retain) NSString * media;

@end
