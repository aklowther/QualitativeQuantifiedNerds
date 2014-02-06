//
//  QUExistingHeadacheTableViewCell.h
//  QQN
//
//  Created by Adam Lowther on 2/3/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QUSeverityProgress.h"

@interface QUExistingHeadacheTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet QUSeverityProgress *headacheSeverity;
@end
