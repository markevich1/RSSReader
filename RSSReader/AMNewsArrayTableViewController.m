//
//  AMNewsArrayTableViewController.m
//  RSSReader
//
//  Created by Gansta_les on 25.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import "AMNewsArrayTableViewController.h"
#import "AMDatabaseManager.h"
#import "News.h"
#import "AMWebViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

static NSString * const tableCellIdentifier = @"cell";
static NSString * const noImage = @"noimage";
static NSString * const segueIdentifier = @"pushWebViewScreen";

@interface AMNewsArrayTableViewController ()

@property(strong, nonatomic) NSArray * newsArray;

@end

@implementation AMNewsArrayTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.newsArray = [[AMDatabaseManager sharedInstance]getNewsArrayFromDatabase];
    
            // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.newsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 44;
    }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 44;
    }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellIdentifier
                                                            forIndexPath:indexPath];
    News * news = [self.newsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = news.title;
    cell.detailTextLabel.text = news.pubDate;
    [cell.imageView setImageWithURL:[NSURL URLWithString:news.media]placeholderImage:[UIImage imageNamed:noImage]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:segueIdentifier]) {
        
        NSIndexPath *indexPath = sender;
        
        AMWebViewController *vc = (AMWebViewController*)[segue destinationViewController];
        vc.url = [[self.newsArray objectAtIndex:indexPath.row] link];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath
                                                                    *)indexPath {
    [self performSegueWithIdentifier:segueIdentifier sender:indexPath];
}
@end
