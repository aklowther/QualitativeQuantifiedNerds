//
//  NSString+NSDateWholeDayPredicate.h
//  QQN
//
//  Created by Adam Lowther on 2/15/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSPredicate (NSDateWholeDayPredicate)
+(NSPredicate *) predicateToRetrieveEventsForDate:(NSDate *)aDate;
@end
