//
//  QUFitbitAPI.h
//  QQN
//
//  Created by Adam Lowther on 2/7/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QUFitbitAPI : NSObject

+(NSMutableDictionary*)getOAuthData;
+(NSDictionary *)getUserInfo;
+(NSDictionary*)getConsumerAppData;

@end
