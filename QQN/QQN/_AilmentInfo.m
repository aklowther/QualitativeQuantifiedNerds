// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AilmentInfo.m instead.

#import "_AilmentInfo.h"

const struct AilmentInfoAttributes AilmentInfoAttributes = {
	.endTime = @"endTime",
	.startTime = @"startTime",
};

const struct AilmentInfoRelationships AilmentInfoRelationships = {
	.ailmentSeverity = @"ailmentSeverity",
	.ailmentType = @"ailmentType",
};

const struct AilmentInfoFetchedProperties AilmentInfoFetchedProperties = {
};

@implementation AilmentInfoID
@end

@implementation _AilmentInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AilmentInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AilmentInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AilmentInfo" inManagedObjectContext:moc_];
}

- (AilmentInfoID*)objectID {
	return (AilmentInfoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic endTime;






@dynamic startTime;






@dynamic ailmentSeverity;

	
- (NSMutableSet*)ailmentSeveritySet {
	[self willAccessValueForKey:@"ailmentSeverity"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"ailmentSeverity"];
  
	[self didAccessValueForKey:@"ailmentSeverity"];
	return result;
}
	

@dynamic ailmentType;

	






@end
