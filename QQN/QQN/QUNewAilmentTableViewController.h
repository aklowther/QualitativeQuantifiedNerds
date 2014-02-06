//
//  QUNewAilmentTableViewController.h
//  QQN
//
//  Created by Adam Lowther on 2/4/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ailment.h"
#import "AilmentInfo.h"

@interface QUNewAilmentTableViewController : UITableViewController
@property (nonatomic) BOOL isModal;
@property (nonatomic) BOOL editingExisting;
@property (nonatomic) Ailment *type;
@property (nonatomic) CGFloat severitySliderValue;
@property (nonatomic) NSDate *registeredTime;
@end
