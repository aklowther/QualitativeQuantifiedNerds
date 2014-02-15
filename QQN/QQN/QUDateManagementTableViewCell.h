//
//  QUDateManagementTableViewCell.h
//  QQN
//
//  Created by Adam Lowther on 2/14/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QUDateManagementTableViewCell : UITableViewCell

@property (nonatomic) NSDate *dateToManage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
