// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AilmentInfo.h instead.

#import <CoreData/CoreData.h>


extern const struct AilmentInfoAttributes {
	__unsafe_unretained NSString *endTime;
	__unsafe_unretained NSString *startTime;
} AilmentInfoAttributes;

extern const struct AilmentInfoRelationships {
	__unsafe_unretained NSString *ailmentSeverity;
	__unsafe_unretained NSString *ailmentType;
} AilmentInfoRelationships;

extern const struct AilmentInfoFetchedProperties {
} AilmentInfoFetchedProperties;

@class Severity;
@class Ailment;




@interface AilmentInfoID : NSManagedObjectID {}
@end

@interface _AilmentInfo : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AilmentInfoID*)objectID;





@property (nonatomic, strong) NSDate* endTime;



//- (BOOL)validateEndTime:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* startTime;



//- (BOOL)validateStartTime:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *ailmentSeverity;

- (NSMutableSet*)ailmentSeveritySet;




@property (nonatomic, strong) Ailment *ailmentType;

//- (BOOL)validateAilmentType:(id*)value_ error:(NSError**)error_;





@end

@interface _AilmentInfo (CoreDataGeneratedAccessors)

- (void)addAilmentSeverity:(NSSet*)value_;
- (void)removeAilmentSeverity:(NSSet*)value_;
- (void)addAilmentSeverityObject:(Severity*)value_;
- (void)removeAilmentSeverityObject:(Severity*)value_;

@end

@interface _AilmentInfo (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveEndTime;
- (void)setPrimitiveEndTime:(NSDate*)value;




- (NSDate*)primitiveStartTime;
- (void)setPrimitiveStartTime:(NSDate*)value;





- (NSMutableSet*)primitiveAilmentSeverity;
- (void)setPrimitiveAilmentSeverity:(NSMutableSet*)value;



- (Ailment*)primitiveAilmentType;
- (void)setPrimitiveAilmentType:(Ailment*)value;


@end
