#import "User.h"


@interface User ()

// Private interface goes here.

@end


@implementation User

// Custom logic goes here.
+(User*)findTheRegisteredUserWithName:(NSString*)name inContext:(NSManagedObjectContext*)context
{
    NSError *error = nil;
    NSDictionary *subVars=[NSDictionary dictionaryWithObject:name forKey:@"CHECK"];
    
    NSFetchRequest *fetchRequest = [context.persistentStoreCoordinator.managedObjectModel fetchRequestFromTemplateWithName:@"checkFirstLastName" substitutionVariables:subVars];
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    if (!results)
        NSLog( @"Error while trying to get  name: %@\n%@", error, [error userInfo] );
    
    User *returnedUser = nil;
    if ([results firstObject] == nil) {
        User *tempUser = (User*)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        [tempUser setFirstName:name];
        
        
        NSError *error = nil;
        [context save:&error];
        if (error != nil) {
            NSLog(@"[%@ saveContext] Error saving context: Error = %@, details = %@",[self class], error,error.userInfo);
        }
        
        returnedUser = tempUser;
    } else {
        returnedUser = [results firstObject];
    }
    return returnedUser;
}

@end
