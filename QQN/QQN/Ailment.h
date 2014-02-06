#import "_Ailment.h"

@interface Ailment : _Ailment {}
// Custom logic goes here.
+(Ailment*)ailmentWithNewestCreatedDateInContext:(NSManagedObjectContext*)context;
@end
