// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Ailment.h instead.

#import <CoreData/CoreData.h>


extern const struct AilmentAttributes {
	__unsafe_unretained NSString *endTime;
	__unsafe_unretained NSString *severity;
	__unsafe_unretained NSString *startTime;
	__unsafe_unretained NSString *type;
} AilmentAttributes;

extern const struct AilmentRelationships {
	__unsafe_unretained NSString *host;
} AilmentRelationships;

extern const struct AilmentFetchedProperties {
} AilmentFetchedProperties;

@class User;






@interface AilmentID : NSManagedObjectID {}
@end

@interface _Ailment : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AilmentID*)objectID;





@property (nonatomic, strong) NSDate* endTime;



//- (BOOL)validateEndTime:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* severity;



@property int16_t severityValue;
- (int16_t)severityValue;
- (void)setSeverityValue:(int16_t)value_;

//- (BOOL)validateSeverity:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* startTime;



//- (BOOL)validateStartTime:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* type;



@property int16_t typeValue;
- (int16_t)typeValue;
- (void)setTypeValue:(int16_t)value_;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) User *host;

//- (BOOL)validateHost:(id*)value_ error:(NSError**)error_;





@end

@interface _Ailment (CoreDataGeneratedAccessors)

@end

@interface _Ailment (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveEndTime;
- (void)setPrimitiveEndTime:(NSDate*)value;




- (NSNumber*)primitiveSeverity;
- (void)setPrimitiveSeverity:(NSNumber*)value;

- (int16_t)primitiveSeverityValue;
- (void)setPrimitiveSeverityValue:(int16_t)value_;




- (NSDate*)primitiveStartTime;
- (void)setPrimitiveStartTime:(NSDate*)value;




- (NSNumber*)primitiveType;
- (void)setPrimitiveType:(NSNumber*)value;

- (int16_t)primitiveTypeValue;
- (void)setPrimitiveTypeValue:(int16_t)value_;





- (User*)primitiveHost;
- (void)setPrimitiveHost:(User*)value;


@end
