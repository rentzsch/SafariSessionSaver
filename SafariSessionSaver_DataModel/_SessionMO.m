// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SessionMO.m instead.

#import "_SessionMO.h"

@implementation SessionMOID
@end

@implementation _SessionMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Session" inManagedObjectContext:moc_];
}

- (SessionMOID*)objectID {
	return (SessionMOID*)[super objectID];
}




@dynamic name;






@dynamic creationDate;






@dynamic pages;

	
- (NSMutableSet*)pagesSet {
	[self willAccessValueForKey:@"pages"];
	NSMutableSet *result = [self mutableSetValueForKey:@"pages"];
	[self didAccessValueForKey:@"pages"];
	return result;
}
	



@end
