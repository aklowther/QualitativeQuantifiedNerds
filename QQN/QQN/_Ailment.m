// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Ailment.m instead.

#import "_Ailment.h"

const struct AilmentAttributes AilmentAttributes = {
	.createdByParse = @"createdByParse",
	.type = @"type",
};

const struct AilmentRelationships AilmentRelationships = {
	.host = @"host",
	.info = @"info",
};

const struct AilmentFetchedProperties AilmentFetchedProperties = {
};

@implementation AilmentID
@end

@implementation _Ailment

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Ailment" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Ailment";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Ailment" inManagedObjectContext:moc_];
}

- (AilmentID*)objectID {
	return (AilmentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic createdByParse;






@dynamic type;






@dynamic host;

	

@dynamic info;

	
- (NSMutableSet*)infoSet {
	[self willAccessValueForKey:@"info"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"info"];
  
	[self didAccessValueForKey:@"info"];
	return result;
}
	






@end
