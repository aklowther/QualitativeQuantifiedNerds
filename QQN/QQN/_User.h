// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

#import <CoreData/CoreData.h>


extern const struct UserAttributes {
	__unsafe_unretained NSString *dob;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *fitbitAuthToken;
	__unsafe_unretained NSString *lastName;
} UserAttributes;

extern const struct UserRelationships {
	__unsafe_unretained NSString *ailment;
	__unsafe_unretained NSString *userTrackedData;
} UserRelationships;

extern const struct UserFetchedProperties {
} UserFetchedProperties;

@class Ailment;
@class UserTrackedData;







@interface UserID : NSManagedObjectID {}
@end

@interface _User : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (UserID*)objectID;





@property (nonatomic, strong) NSDate* dob;



//- (BOOL)validateDob:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* email;



//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* firstName;



//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* fitbitAuthToken;



//- (BOOL)validateFitbitAuthToken:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* lastName;



//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *ailment;

- (NSMutableSet*)ailmentSet;




@property (nonatomic, strong) NSSet *userTrackedData;

- (NSMutableSet*)userTrackedDataSet;




+ (NSArray*)fetchCheckFirstLastName:(NSManagedObjectContext*)moc_ CHECK:(NSString*)CHECK_ ;
+ (NSArray*)fetchCheckFirstLastName:(NSManagedObjectContext*)moc_ CHECK:(NSString*)CHECK_ error:(NSError**)error_;




@end

@interface _User (CoreDataGeneratedAccessors)

- (void)addAilment:(NSSet*)value_;
- (void)removeAilment:(NSSet*)value_;
- (void)addAilmentObject:(Ailment*)value_;
- (void)removeAilmentObject:(Ailment*)value_;

- (void)addUserTrackedData:(NSSet*)value_;
- (void)removeUserTrackedData:(NSSet*)value_;
- (void)addUserTrackedDataObject:(UserTrackedData*)value_;
- (void)removeUserTrackedDataObject:(UserTrackedData*)value_;

@end

@interface _User (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveDob;
- (void)setPrimitiveDob:(NSDate*)value;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveFitbitAuthToken;
- (void)setPrimitiveFitbitAuthToken:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;





- (NSMutableSet*)primitiveAilment;
- (void)setPrimitiveAilment:(NSMutableSet*)value;



- (NSMutableSet*)primitiveUserTrackedData;
- (void)setPrimitiveUserTrackedData:(NSMutableSet*)value;


@end
