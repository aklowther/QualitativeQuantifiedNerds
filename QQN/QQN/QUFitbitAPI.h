//
//  QUFitbitAPI.h
//  QQN
//
//  Created by Adam Lowther on 2/7/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QUFitbitAPI : NSObject

+(NSDictionary*)getConsumerAppData;
+(NSMutableDictionary*)getOAuthData;
+(NSDictionary *)getUserInfo;
+(NSDictionary *)getWaterForDate:(NSDate*)date;
+(NSDictionary*) getActivitiesForDate:(NSDate*)date;
+(NSDictionary*) getBodyMeasurementsForDate:(NSDate*)date;


@end
