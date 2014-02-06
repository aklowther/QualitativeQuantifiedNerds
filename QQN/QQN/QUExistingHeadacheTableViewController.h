//
//  QUExistingHeadacheTableViewController.h
//  QQN
//
//  Created by Adam Lowther on 2/3/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ailment.h"
#import "AilmentInfo.h"
#import "Severity.h"

@interface QUExistingHeadacheTableViewController : UITableViewController
@property (nonatomic) NSPredicate *predicate;
@property (nonatomic) Ailment *ailment;
@end
