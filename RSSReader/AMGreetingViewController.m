//
//  AMViewController.m
//  RSSReader
//
//  Created by Gansta_les on 19.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import "AMGreetingViewController.h"
#import "AMParser.h"

static NSString * const segueIdentifier = @"push";
static NSString * const loadingKey = @"loading";
static NSString * const errorKey = @"error";

@interface AMGreetingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@end

@implementation AMGreetingViewController
//const NSString *segueIdentifier = @"push";
- (void)viewDidLoad

{
    [super viewDidLoad];
    [AMParser sharedInstance].delegate = self;
    self.loadingLabel.text = NSLocalizedString(loadingKey, nil);
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
    [self performSegueWithIdentifier:segueIdentifier sender:nil];
}

- (void)failedWithError:(NSError*)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorKey
                                                    message:[error localizedDescription]
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
