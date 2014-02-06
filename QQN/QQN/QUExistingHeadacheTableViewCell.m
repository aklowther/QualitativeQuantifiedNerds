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
//    [self.headacheSeverity setGradientColors:@[//HexToUIColor(0x00FF00),
//                                               //HexToUIColor(0x12FF00),
//                                               //HexToUIColor(0x24FF00),
//                                               HexToUIColor(0x35FF00),
//                                               HexToUIColor(0x47FF00),
//                                               HexToUIColor(0x58FF00),
//                                               HexToUIColor(0x6AFF00),
//                                               HexToUIColor(0x7CFF00),
//                                               HexToUIColor(0x8DFF00),
//                                               HexToUIColor(0x9FFF00),
//                                               HexToUIColor(0xB0FF00),
//                                               HexToUIColor(0xC2FF00),
//                                               HexToUIColor(0xD4FF00),
//                                               HexToUIColor(0xE5FF00),
//                                               HexToUIColor(0xF7FF00),
//                                               HexToUIColor(0xFFF600),
//                                               HexToUIColor(0xFFE400),
//                                               HexToUIColor(0xFFD300),
//                                               HexToUIColor(0xFFC100),
//                                               HexToUIColor(0xFFAF00),
//                                               HexToUIColor(0xFF9E00),
//                                               HexToUIColor(0xFF8C00),
//                                               HexToUIColor(0xFF7B00),
//                                               HexToUIColor(0xFF6900),
//                                               HexToUIColor(0xFF5700),
//                                               HexToUIColor(0xFF4600),
//                                               HexToUIColor(0xFF3400),
//                                               HexToUIColor(0xFF1100),
//                                               HexToUIColor(0xFF2300),
//                                               HexToUIColor(0xFF0000)]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
