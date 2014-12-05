//
//  AMNews.m
//  RSSReader
//
//  Created by Gansta_les on 20.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import "AMNews.h"
#import "News.h"

@implementation AMNews

-(void)createEntity
{
    News *news = [News MR_createEntity];
    news.title = self.title;
    news.link = self.link;
    news.pubDate = self.pubDate;
    news.media = self.media;
}

@end
