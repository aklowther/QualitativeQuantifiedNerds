//
//  QUDateManagementTableViewCell.m
//  QQN
//
//  Created by Adam Lowther on 2/14/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUDateManagementTableViewCell.h"

@implementation QUDateManagementTableViewCell

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

-(void)dealloc
{
    self.dateToManage = nil;
}

@end
