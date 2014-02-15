// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Severity.m instead.

#import "_Severity.h"

const struct SeverityAttributes SeverityAttributes = {
	.currentSeverity = @"currentSeverity",
	.humidity = @"humidity",
	.temperature = @"temperature",
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
	if ([key isEqualToString:@"humidityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"humidity"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"temperatureValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"temperature"];
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





@dynamic humidity;



- (float)humidityValue {
	NSNumber *result = [self humidity];
	return [result floatValue];
}

- (void)setHumidityValue:(float)value_ {
	[self setHumidity:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveHumidityValue {
	NSNumber *result = [self primitiveHumidity];
	return [result floatValue];
}

- (void)setPrimitiveHumidityValue:(float)value_ {
	[self setPrimitiveHumidity:[NSNumber numberWithFloat:value_]];
}





@dynamic temperature;



- (float)temperatureValue {
	NSNumber *result = [self temperature];
	return [result floatValue];
}

- (void)setTemperatureValue:(float)value_ {
	[self setTemperature:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveTemperatureValue {
	NSNumber *result = [self primitiveTemperature];
	return [result floatValue];
}

- (void)setPrimitiveTemperatureValue:(float)value_ {
	[self setPrimitiveTemperature:[NSNumber numberWithFloat:value_]];
}





@dynamic time;






@dynamic info;

	






@end
