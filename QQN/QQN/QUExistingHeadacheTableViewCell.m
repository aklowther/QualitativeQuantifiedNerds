//
//  QUExistingHeadacheTableViewCell.m
//  QQN
//
//  Created by Adam Lowther on 2/3/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUExistingHeadacheTableViewCell.h"

@implementation QUExistingHeadacheTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //NOT CALLED WHEN CELL IS DEQUEUED
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
//    NSLog(@"awake called");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
