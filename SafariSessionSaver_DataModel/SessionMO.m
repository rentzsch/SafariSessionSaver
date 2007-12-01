#import "SessionMO.h"

@implementation SessionMO

- (void)awakeFromInsert {
	[super awakeFromInsert];
	[self setCreationDate:[[[NSDate alloc] init] autorelease]];
}

@end
