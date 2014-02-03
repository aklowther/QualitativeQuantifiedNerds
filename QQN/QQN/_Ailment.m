// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Ailment.m instead.

#import "_Ailment.h"

const struct AilmentAttributes AilmentAttributes = {
	.endTime = @"endTime",
	.severity = @"severity",
	.startTime = @"startTime",
	.type = @"type",
};

const struct AilmentRelationships AilmentRelationships = {
	.host = @"host",
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
	
	if ([key isEqualToString:@"severityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"severity"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"typeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"type"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic endTime;






@dynamic severity;



- (int16_t)severityValue {
	NSNumber *result = [self severity];
	return [result shortValue];
}

- (void)setSeverityValue:(int16_t)value_ {
	[self setSeverity:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveSeverityValue {
	NSNumber *result = [self primitiveSeverity];
	return [result shortValue];
}

- (void)setPrimitiveSeverityValue:(int16_t)value_ {
	[self setPrimitiveSeverity:[NSNumber numberWithShort:value_]];
}





@dynamic startTime;






@dynamic type;



- (int16_t)typeValue {
	NSNumber *result = [self type];
	return [result shortValue];
}

- (void)setTypeValue:(int16_t)value_ {
	[self setType:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveTypeValue {
	NSNumber *result = [self primitiveType];
	return [result shortValue];
}

- (void)setPrimitiveTypeValue:(int16_t)value_ {
	[self setPrimitiveType:[NSNumber numberWithShort:value_]];
}





@dynamic host;

	






@end
