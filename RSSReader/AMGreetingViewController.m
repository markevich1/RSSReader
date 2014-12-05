//
//  AMViewController.m
//  RSSReader
//
//  Created by Gansta_les on 19.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import "AMGreetingViewController.h"
#import "AMParser.h"

static NSString * const loadingKey = @"loading";
static NSString * const errorKey = @"error";
static NSString * const nextButtonKey = @"show";
static NSString * const reloadButtonKey = @"reload";

@interface AMGreetingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
- (IBAction)reloadButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndikator;

@end

@implementation AMGreetingViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
    self.loadingLabel.hidden = YES;
    self.activityIndikator.hidden = YES;
    [AMParser sharedInstance].delegate = self;
    self.loadingLabel.text = NSLocalizedString(loadingKey, nil);
    [self.nextButton setTitle:NSLocalizedString(nextButtonKey, nil) forState:UIControlStateNormal];
    [self.reloadButton setTitle:NSLocalizedString(reloadButtonKey, nil) forState:UIControlStateNormal];
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
}

-(void)endLoading
{
    self.loadingLabel.hidden = YES;
    self.activityIndikator.hidden = YES;
}

- (void)failedWithError:(NSError*)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(errorKey, nil)
                                                    message:[error localizedDescription]
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
    [self endLoading];
}

- (IBAction)reloadButtonAction:(id)sender {
    self.loadingLabel.hidden = NO;
    self.activityIndikator.hidden = NO;
    [[AMParser sharedInstance] getAndParseRSS];
}
@end
