//
//  QUM7Manager.m
//  QQN
//
//  Created by Adam Lowther on 2/12/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUM7Manager.h"

@implementation QUM7Manager

+(void)getStepsIfM7Available
{
    if ([CMStepCounter isStepCountingAvailable]) {
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
        [components setHour:0];
        NSDate *todayStart = [calendar dateFromComponents:components];
        
        CMStepCounter *stepCount = [[CMStepCounter alloc] init];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
        [stepCount queryStepCountStartingFrom:todayStart to:[NSDate date] toQueue:queue withHandler:^(NSInteger numberOfSteps, NSError *error) {
            if (!error) {
                [[[UIAlertView alloc] initWithTitle:@"Steps"
                                           message:[NSString stringWithFormat:@"You've taken %i steps with your phone today", numberOfSteps]
                                          delegate:nil
                                 cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil, nil] show];
            }
        }];
    }
}

@end
