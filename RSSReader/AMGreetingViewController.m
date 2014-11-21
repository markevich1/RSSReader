//
//  AMViewController.m
//  RSSReader
//
//  Created by Gansta_les on 19.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import "AMGreetingViewController.h"
#import "AMParser.h"


@interface AMGreetingViewController ()

@end

@implementation AMGreetingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[AMParser sharedInstance] getAndParseRSS];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"push" sender:nil];
        });
    });}
@end
