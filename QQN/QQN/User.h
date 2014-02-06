#import "_User.h"

@interface User : _User {}
// Custom logic goes here.

+(User*)findTheRegisteredUserWithName:(NSString*)name inContext:(NSManagedObjectContext*)context;

@end
