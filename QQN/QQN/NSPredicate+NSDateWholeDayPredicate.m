//
//  NSString+NSDateWholeDayPredicate.m
//  QQN
//
//  Created by Adam Lowther on 2/15/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "NSPredicate+NSDateWholeDayPredicate.h"

@implementation NSPredicate (NSDateWholeDayPredicate)


+(NSPredicate *) predicateToRetrieveEventsForDate:(NSDate *)aDate
{
    
    // start by retrieving day, weekday, month and year components for the given day
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *todayComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:aDate];
    NSInteger theDay = [todayComponents day];
    NSInteger theMonth = [todayComponents month];
    NSInteger theYear = [todayComponents year];
    
    // now build a NSDate object for the input date using these components
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:theDay];
    [components setMonth:theMonth];
    [components setYear:theYear];
    [components setHour:0.0];
    [components setMinute:0.0];
    NSDate *thisDate = [gregorian dateFromComponents:components];
    
    // build a NSDate object for aDate next day
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:1];
    NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:thisDate options:0];
    
    // build the predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"date < %@ && date > %@", nextDate, thisDate];
    
    return predicate;
}


@end
