// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Ailment.h instead.

#import <CoreData/CoreData.h>


extern const struct AilmentAttributes {
	__unsafe_unretained NSString *createdByParse;
	__unsafe_unretained NSString *type;
} AilmentAttributes;

extern const struct AilmentRelationships {
	__unsafe_unretained NSString *host;
	__unsafe_unretained NSString *info;
} AilmentRelationships;

extern const struct AilmentFetchedProperties {
} AilmentFetchedProperties;

@class User;
@class AilmentInfo;




@interface AilmentID : NSManagedObjectID {}
@end

@interface _Ailment : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AilmentID*)objectID;





@property (nonatomic, strong) NSDate* createdByParse;



//- (BOOL)validateCreatedByParse:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* type;



//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) User *host;

//- (BOOL)validateHost:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *info;

- (NSMutableSet*)infoSet;





@end

@interface _Ailment (CoreDataGeneratedAccessors)

- (void)addInfo:(NSSet*)value_;
- (void)removeInfo:(NSSet*)value_;
- (void)addInfoObject:(AilmentInfo*)value_;
- (void)removeInfoObject:(AilmentInfo*)value_;

@end

@interface _Ailment (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCreatedByParse;
- (void)setPrimitiveCreatedByParse:(NSDate*)value;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;





- (User*)primitiveHost;
- (void)setPrimitiveHost:(User*)value;



- (NSMutableSet*)primitiveInfo;
- (void)setPrimitiveInfo:(NSMutableSet*)value;


@end
