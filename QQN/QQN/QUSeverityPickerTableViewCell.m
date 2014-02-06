//
//  QUSeverityPickerTableViewCell.m
//  QQN
//
//  Created by Adam Lowther on 2/4/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUSeverityPickerTableViewCell.h"

@implementation QUSeverityPickerTableViewCell

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
    [self.severitySlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    NSString *sliderValue = [NSString stringWithFormat:@"%.2f/10", self.severitySlider.value*10];
    [self.sliderValueLabel setText:sliderValue];
}

-(void)sliderValueChanged:(UISlider*)slider
{
    NSString *sliderValue = [NSString stringWithFormat:@"%.2f/10", slider.value*10];
    [self.sliderValueLabel setText:sliderValue];
    [self.delegate severitySliderValueChanged:slider];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
