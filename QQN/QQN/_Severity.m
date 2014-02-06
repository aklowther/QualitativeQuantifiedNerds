// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Severity.m instead.

#import "_Severity.h"

const struct SeverityAttributes SeverityAttributes = {
	.currentSeverity = @"currentSeverity",
	.time = @"time",
};

const struct SeverityRelationships SeverityRelationships = {
	.info = @"info",
};

const struct SeverityFetchedProperties SeverityFetchedProperties = {
};

@implementation SeverityID
@end

@implementation _Severity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Severity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Severity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Severity" inManagedObjectContext:moc_];
}

- (SeverityID*)objectID {
	return (SeverityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"currentSeverityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"currentSeverity"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic currentSeverity;



- (float)currentSeverityValue {
	NSNumber *result = [self currentSeverity];
	return [result floatValue];
}

- (void)setCurrentSeverityValue:(float)value_ {
	[self setCurrentSeverity:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveCurrentSeverityValue {
	NSNumber *result = [self primitiveCurrentSeverity];
	return [result floatValue];
}

- (void)setPrimitiveCurrentSeverityValue:(float)value_ {
	[self setPrimitiveCurrentSeverity:[NSNumber numberWithFloat:value_]];
}





@dynamic time;






@dynamic info;

	






@end
