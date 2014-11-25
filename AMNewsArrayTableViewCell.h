//
//  AMNewsArrayTableViewCell.h
//  RSSReader
//
//  Created by Gansta_les on 25.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMNewsArrayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDateLabel;

@end
