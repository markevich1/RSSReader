//
//  AMViewController.m
//  RSSReader
//
//  Created by Gansta_les on 19.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import "AMViewController.h"
#import "AMParser.h"


@interface AMViewController ()

@end

@implementation AMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[AMParser sharedInstance] getAndParseRSS];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
