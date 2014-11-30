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
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@end

@implementation AMGreetingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AMParser sharedInstance].delegate = self;
    self.loadingLabel.text = NSLocalizedString(@"loading", nil);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
        
    [[AMParser sharedInstance] getAndParseRSS];
}

-(void)showNewsArrayScreen
{
    [self performSegueWithIdentifier:@"push" sender:nil];
}
@end
