//
//  AMNewsArrayTableViewCell.m
//  RSSReader
//
//  Created by Gansta_les on 25.11.14.
//  Copyright (c) 2014 Gansta_les. All rights reserved.
//

#import "AMNewsArrayTableViewCell.h"

@implementation AMNewsArrayTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
