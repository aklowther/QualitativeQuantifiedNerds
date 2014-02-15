//
//  QUM7Manager.h
//  QQN
//
//  Created by Adam Lowther on 2/12/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface QUM7Manager : NSObject

@property (nonatomic) BOOL deviceHasM7;

+(void)getStepsIfM7Available;

@end
