// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserTrackedData.m instead.

#import "_UserTrackedData.h"

const struct UserTrackedDataAttributes UserTrackedDataAttributes = {
	.date = @"date",
	.steps = @"steps",
	.totalSleep = @"totalSleep",
	.water = @"water",
};

const struct UserTrackedDataRelationships UserTrackedDataRelationships = {
	.user = @"user",
};

const struct UserTrackedDataFetchedProperties UserTrackedDataFetchedProperties = {
};

@implementation UserTrackedDataID
@end

@implementation _UserTrackedData

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"UserTrackedData" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"UserTrackedData";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"UserTrackedData" inManagedObjectContext:moc_];
}

- (UserTrackedDataID*)objectID {
	return (UserTrackedDataID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"stepsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"steps"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"totalSleepValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"totalSleep"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"waterValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"water"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic date;






@dynamic steps;



- (int32_t)stepsValue {
	NSNumber *result = [self steps];
	return [result intValue];
}

- (void)setStepsValue:(int32_t)value_ {
	[self setSteps:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveStepsValue {
	NSNumber *result = [self primitiveSteps];
	return [result intValue];
}

- (void)setPrimitiveStepsValue:(int32_t)value_ {
	[self setPrimitiveSteps:[NSNumber numberWithInt:value_]];
}





@dynamic totalSleep;



- (float)totalSleepValue {
	NSNumber *result = [self totalSleep];
	return [result floatValue];
}

- (void)setTotalSleepValue:(float)value_ {
	[self setTotalSleep:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveTotalSleepValue {
	NSNumber *result = [self primitiveTotalSleep];
	return [result floatValue];
}

- (void)setPrimitiveTotalSleepValue:(float)value_ {
	[self setPrimitiveTotalSleep:[NSNumber numberWithFloat:value_]];
}





@dynamic water;



- (float)waterValue {
	NSNumber *result = [self water];
	return [result floatValue];
}

- (void)setWaterValue:(float)value_ {
	[self setWater:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveWaterValue {
	NSNumber *result = [self primitiveWater];
	return [result floatValue];
}

- (void)setPrimitiveWaterValue:(float)value_ {
	[self setPrimitiveWater:[NSNumber numberWithFloat:value_]];
}





@dynamic user;

	






@end
