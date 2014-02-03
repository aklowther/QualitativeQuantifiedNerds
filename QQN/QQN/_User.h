// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

#import <CoreData/CoreData.h>


extern const struct UserAttributes {
	__unsafe_unretained NSString *dob;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
} UserAttributes;

extern const struct UserRelationships {
	__unsafe_unretained NSString *ailment;
} UserRelationships;

extern const struct UserFetchedProperties {
} UserFetchedProperties;

@class Ailment;






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





@property (nonatomic, strong) NSString* lastName;



//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *ailment;

- (NSMutableSet*)ailmentSet;





@end

@interface _User (CoreDataGeneratedAccessors)

- (void)addAilment:(NSSet*)value_;
- (void)removeAilment:(NSSet*)value_;
- (void)addAilmentObject:(Ailment*)value_;
- (void)removeAilmentObject:(Ailment*)value_;

@end

@interface _User (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveDob;
- (void)setPrimitiveDob:(NSDate*)value;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;





- (NSMutableSet*)primitiveAilment;
- (void)setPrimitiveAilment:(NSMutableSet*)value;


@end
