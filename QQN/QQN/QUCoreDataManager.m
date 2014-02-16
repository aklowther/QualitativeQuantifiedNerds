//
//  QUCoreDataManager.m
//  QQN
//
//  Created by Adam Lowther on 2/3/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUCoreDataManager.h"
#import "AilmentInfo.h"
#import "Ailment.h"
#import "UserTrackedData.h"
#import "NSPredicate+NSDateWholeDayPredicate.h"

#import <Parse/Parse.h>


@implementation QUCoreDataManager

+(QUCoreDataManager*)sharedManager
{
    static dispatch_once_t token = 0;
    static QUCoreDataManager *sharedMgr = NULL;
    
    dispatch_once( &token, ^{
        sharedMgr = [[QUCoreDataManager alloc] init];
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        sharedMgr.model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"QUser" ofType:@"momd"]]];
        sharedMgr.coord = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:sharedMgr.model];
        
        sharedMgr.context = [[NSManagedObjectContext alloc] init];
        [sharedMgr.context setPersistentStoreCoordinator:sharedMgr.coord];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSURL *storeURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/qu.db", paths[0]]];
        
        sharedMgr.store = [sharedMgr.coord addPersistentStoreWithType:NSSQLiteStoreType
                                                        configuration:nil
                                                                  URL:storeURL
                                                              options:options
                                                                error:NULL];
    });
    
    return sharedMgr;
}

-(void)setAilments:(NSArray*)ailments
{
    if ([ailments count] > 0) {
        [self addAilments:ailments];
    }
}

-(void)addAilments:(NSArray*)ailmentsToAdd
{
    User *person = [User findTheRegisteredUserWithName:@"Temp" inContext:[self context]];
    for (PFObject *tempAilment in ailmentsToAdd) {
        Ailment *parseAilment = [NSEntityDescription insertNewObjectForEntityForName:@"Ailment" inManagedObjectContext:[self context]];
        [parseAilment setType:tempAilment[@"type"]];
        [parseAilment setCreatedByParse:tempAilment.createdAt];
        [parseAilment setHost:person];
        [self.context insertObject:parseAilment];
    }

    NSError *error = nil;
    [self.context save:&error];
    if (error != nil) {
        NSLog(@"[%@ saveContext] Error saving context: Error = %@, details = %@",[self class], error,error.userInfo);
    }
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.zzz'Z'"];
//    NSDate *updated = [dateFormatter dateFromString:[dict objectForKey:@"updatedAt"]];
//    NSDate *created = [dateFormatter dateFromString:[dict objectForKey:@"createdAt"]];
//    
//    dateFormatter.dateFormat = @"HHmm";
//    NSDate *date = [dateFormatter dateFromString:[dict objectForKey:@"time"]];
//    
//    dateFormatter.dateFormat = @"hh:mm a";
//    NSString *pmamDateString = [dateFormatter stringFromDate:date];

}

-(void)setUserTrackedData:(NSDictionary *)trackData forDate:(NSDate*)dateToSet
{
    NSPredicate *datePredicate = [NSPredicate predicateToRetrieveEventsForDate:dateToSet];
    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"user.firstName = %@",  @"Temp"];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[userPredicate, datePredicate]];
    
    NSArray *existingData = [self getArrayOfDataFromEntity:@"UserTrackedData" withPredicate:predicate];
    [self addUserTrackedData:trackData unlessExisting:existingData forDate:dateToSet];
//    if ([trackData count] < [existingSavedStaffMembers count]) {
//        [self removeHoursOfService:staffData fromExistingServices:existingSavedStaffMembers];
//    }
    
}

-(void)addUserTrackedData:(NSDictionary*)data unlessExisting:(NSArray*)existingData forDate:(NSDate*)dateToSet
{
    UserTrackedData *trackedEntity = nil;
    if (existingData.count == 1) {
        trackedEntity = (UserTrackedData*)[existingData firstObject];
        
    } else {
        User *person = [User findTheRegisteredUserWithName:@"Temp" inContext:[self context]];
        trackedEntity = (UserTrackedData*)[NSEntityDescription insertNewObjectForEntityForName:@"UserTrackedData" inManagedObjectContext:[self context]];
        [trackedEntity setUser:person];
        [trackedEntity setDate:dateToSet];
    }
    
    if (data[@"summary"] != nil) {
        if (data[@"summary"][@"water"] != nil) {
            [trackedEntity setWater:data[@"summary"][@"water"]];
        } else if (data[@"summary"][@"steps"] != nil) {
            [trackedEntity setSteps:data[@"summary"][@"steps"]];
        }
    }
    [trackedEntity setDate:dateToSet];
    
    NSError *error = nil;
    [self.context save:&error];
    if (error != nil) {
        NSLog(@"[%@ saveContext] Error saving context: Error = %@, details = %@",[self class], error,error.userInfo);
    }
}

-(NSArray*)getArrayOfDataFromEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if(predicate != nil)
    {
        [request setPredicate:predicate];
    }
    [request setResultType:NSManagedObjectResultType];
    NSError *error = nil;
    NSArray *returnedFetchData = [self.context executeFetchRequest:request error:&error];
    if (error != nil) {
        NSLog(@"ERROR");
    }
    return returnedFetchData;
}

@end
