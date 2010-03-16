// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PageMO.m instead.

#import "_PageMO.h"

@implementation PageMOID
@end

@implementation _PageMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Page" inManagedObjectContext:moc_];
}

- (PageMOID*)objectID {
	return (PageMOID*)[super objectID];
}




@dynamic url;






@dynamic newRelationship;

	



@end
