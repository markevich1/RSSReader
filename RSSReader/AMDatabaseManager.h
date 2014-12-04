//
//  AMDatabaseManager.h
//  RSSReader
//
//  Created by Gansta_les on 21.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMDatabaseManager : NSObject

+ (AMDatabaseManager *)sharedInstance;
-(void)saveNewsArrayToDatabase:(NSArray*)newsArray completion:(void(^)(void))callback;
-(NSArray*)getNewsArrayFromDatabase;

@end
