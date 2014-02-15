//
//  QUSeverityPickerTableViewCell.h
//  QQN
//
//  Created by Adam Lowther on 2/4/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QUSeverityDelegate <NSObject>

-(void)severitySliderValueChanged:(UISlider*)slider;

@end


@interface QUSeverityPickerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *severityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderValueLabel;
@property (weak, nonatomic) IBOutlet UISlider *severitySlider;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;

@property (nonatomic)id<QUSeverityDelegate> delegate;
@end
