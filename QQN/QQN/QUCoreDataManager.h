//
//  QUCoreDataManager.h
//  QQN
//
//  Created by Adam Lowther on 2/3/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface QUCoreDataManager : NSObject

@property (nonatomic, retain) NSPersistentStore *store;
@property (nonatomic, retain) NSPersistentStoreCoordinator *coord;
@property (nonatomic, retain) NSManagedObjectModel *model;
@property (nonatomic, retain) NSManagedObjectContext *context;

+(QUCoreDataManager*)sharedManager;
-(NSArray*)getArrayOfDataFromEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate;
-(void)setAilments:(NSArray*)ailments;

@end
