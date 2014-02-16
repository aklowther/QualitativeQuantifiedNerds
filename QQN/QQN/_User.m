// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.m instead.

#import "_User.h"

const struct UserAttributes UserAttributes = {
	.dob = @"dob",
	.email = @"email",
	.firstName = @"firstName",
	.fitbitAuthToken = @"fitbitAuthToken",
	.lastName = @"lastName",
};

const struct UserRelationships UserRelationships = {
	.ailment = @"ailment",
	.userTrackedData = @"userTrackedData",
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






@dynamic fitbitAuthToken;






@dynamic lastName;






@dynamic ailment;

	
- (NSMutableSet*)ailmentSet {
	[self willAccessValueForKey:@"ailment"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"ailment"];
  
	[self didAccessValueForKey:@"ailment"];
	return result;
}
	

@dynamic userTrackedData;

	
- (NSMutableSet*)userTrackedDataSet {
	[self willAccessValueForKey:@"userTrackedData"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"userTrackedData"];
  
	[self didAccessValueForKey:@"userTrackedData"];
	return result;
}
	






+ (NSArray*)fetchCheckFirstLastName:(NSManagedObjectContext*)moc_ CHECK:(NSString*)CHECK_ {
	NSError *error = nil;
	NSArray *result = [self fetchCheckFirstLastName:moc_ CHECK:CHECK_ error:&error];
	if (error) {
#ifdef NSAppKitVersionNumber10_0
		[NSApp presentError:error];
#else
		NSLog(@"error: %@", error);
#endif
	}
	return result;
}
+ (NSArray*)fetchCheckFirstLastName:(NSManagedObjectContext*)moc_ CHECK:(NSString*)CHECK_ error:(NSError**)error_ {
	NSParameterAssert(moc_);
	NSError *error = nil;

	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	
	NSDictionary *substitutionVariables = [NSDictionary dictionaryWithObjectsAndKeys:
														
														CHECK_, @"CHECK",
														
														nil];
	
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"checkFirstLastName"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"checkFirstLastName\".");

	NSArray *result = [moc_ executeFetchRequest:fetchRequest error:&error];
	if (error_) *error_ = error;
	return result;
}



@end
