#import "Ailment.h"


@interface Ailment ()

// Private interface goes here.

@end


@implementation Ailment

// Custom logic goes here.
+(Ailment*)ailmentWithNewestCreatedDateInContext:(NSManagedObjectContext*)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Ailment"];
    
    fetchRequest.fetchLimit = 1;
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createdByParse" ascending:NO]];
    
    NSError *error = nil;
    
    Ailment *returnAilment = [context executeFetchRequest:fetchRequest error:&error].lastObject;
    
    return returnAilment;
}

@end
