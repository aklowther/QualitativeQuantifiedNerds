// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.m instead.

#import "_User.h"

const struct UserAttributes UserAttributes = {
	.dob = @"dob",
	.email = @"email",
	.firstName = @"firstName",
	.lastName = @"lastName",
};

const struct UserRelationships UserRelationships = {
	.ailment = @"ailment",
};

const struct UserFetchedProperties UserFetchedProperties = {
};

@implementation UserID
@end

@implementation _User

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"User";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc_];
}

- (UserID*)objectID {
	return (UserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic dob;






@dynamic email;






@dynamic firstName;






@dynamic lastName;






@dynamic ailment;

	
- (NSMutableSet*)ailmentSet {
	[self willAccessValueForKey:@"ailment"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"ailment"];
  
	[self didAccessValueForKey:@"ailment"];
	return result;
}
	






@end
