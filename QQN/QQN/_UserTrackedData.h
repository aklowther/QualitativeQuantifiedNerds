// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserTrackedData.h instead.

#import <CoreData/CoreData.h>


extern const struct UserTrackedDataAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *steps;
	__unsafe_unretained NSString *totalSleep;
	__unsafe_unretained NSString *water;
} UserTrackedDataAttributes;

extern const struct UserTrackedDataRelationships {
	__unsafe_unretained NSString *user;
} UserTrackedDataRelationships;

extern const struct UserTrackedDataFetchedProperties {
} UserTrackedDataFetchedProperties;

@class User;






@interface UserTrackedDataID : NSManagedObjectID {}
@end

@interface _UserTrackedData : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (UserTrackedDataID*)objectID;





@property (nonatomic, strong) NSDate* date;



//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* steps;



@property int32_t stepsValue;
- (int32_t)stepsValue;
- (void)setStepsValue:(int32_t)value_;

//- (BOOL)validateSteps:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* totalSleep;



@property float totalSleepValue;
- (float)totalSleepValue;
- (void)setTotalSleepValue:(float)value_;

//- (BOOL)validateTotalSleep:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* water;



@property float waterValue;
- (float)waterValue;
- (void)setWaterValue:(float)value_;

//- (BOOL)validateWater:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) User *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _UserTrackedData (CoreDataGeneratedAccessors)

@end

@interface _UserTrackedData (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;




- (NSNumber*)primitiveSteps;
- (void)setPrimitiveSteps:(NSNumber*)value;

- (int32_t)primitiveStepsValue;
- (void)setPrimitiveStepsValue:(int32_t)value_;




- (NSNumber*)primitiveTotalSleep;
- (void)setPrimitiveTotalSleep:(NSNumber*)value;

- (float)primitiveTotalSleepValue;
- (void)setPrimitiveTotalSleepValue:(float)value_;




- (NSNumber*)primitiveWater;
- (void)setPrimitiveWater:(NSNumber*)value;

- (float)primitiveWaterValue;
- (void)setPrimitiveWaterValue:(float)value_;





- (User*)primitiveUser;
- (void)setPrimitiveUser:(User*)value;


@end
