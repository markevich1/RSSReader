//
//  AMDatabaseManager.m
//  RSSReader
//
//  Created by Gansta_les on 21.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import "AMDatabaseManager.h"
#import "News.h"
#import "AMNews.h"

@implementation AMDatabaseManager

+ (AMDatabaseManager *)sharedInstance
{
    static AMDatabaseManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AMDatabaseManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

-(void)saveNewsArrayToDatabase:(NSArray*)newsArray
{
    [News MR_truncateAll];
    for(AMNews *news in newsArray){
        [news saveNewsToDatabase];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

-(NSArray*)getNewsArrayFromDatabase
{
    NSArray *array = [News MR_findAll];
    return array;
}
@end
