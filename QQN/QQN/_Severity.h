// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Severity.h instead.

#import <CoreData/CoreData.h>


extern const struct SeverityAttributes {
	__unsafe_unretained NSString *currentSeverity;
	__unsafe_unretained NSString *time;
} SeverityAttributes;

extern const struct SeverityRelationships {
	__unsafe_unretained NSString *info;
} SeverityRelationships;

extern const struct SeverityFetchedProperties {
} SeverityFetchedProperties;

@class AilmentInfo;




@interface SeverityID : NSManagedObjectID {}
@end

@interface _Severity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SeverityID*)objectID;





@property (nonatomic, strong) NSNumber* currentSeverity;



@property float currentSeverityValue;
- (float)currentSeverityValue;
- (void)setCurrentSeverityValue:(float)value_;

//- (BOOL)validateCurrentSeverity:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* time;



//- (BOOL)validateTime:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) AilmentInfo *info;

//- (BOOL)validateInfo:(id*)value_ error:(NSError**)error_;





@end

@interface _Severity (CoreDataGeneratedAccessors)

@end

@interface _Severity (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCurrentSeverity;
- (void)setPrimitiveCurrentSeverity:(NSNumber*)value;

- (float)primitiveCurrentSeverityValue;
- (void)setPrimitiveCurrentSeverityValue:(float)value_;




- (NSDate*)primitiveTime;
- (void)setPrimitiveTime:(NSDate*)value;





- (AilmentInfo*)primitiveInfo;
- (void)setPrimitiveInfo:(AilmentInfo*)value;


@end
