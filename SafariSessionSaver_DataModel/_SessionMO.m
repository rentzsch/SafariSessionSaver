// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SessionMO.m instead.

#import "_SessionMO.h"

@implementation _SessionMO



- (NSString*)name {
	[self willAccessValueForKey:@"name"];
	NSString *result = [self primitiveValueForKey:@"name"];
	[self didAccessValueForKey:@"name"];
	return result;
}

- (void)setName:(NSString*)value_ {
	[self willChangeValueForKey:@"name"];
	[self setPrimitiveValue:value_ forKey:@"name"];
	[self didChangeValueForKey:@"name"];
}






- (NSDate*)creationDate {
	[self willAccessValueForKey:@"creationDate"];
	NSDate *result = [self primitiveValueForKey:@"creationDate"];
	[self didAccessValueForKey:@"creationDate"];
	return result;
}

- (void)setCreationDate:(NSDate*)value_ {
	[self willChangeValueForKey:@"creationDate"];
	[self setPrimitiveValue:value_ forKey:@"creationDate"];
	[self didChangeValueForKey:@"creationDate"];
}






	
- (void)addPages:(NSSet*)value_ {
	[self willChangeValueForKey:@"pages" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value_];
	[[self primitiveValueForKey:@"pages"] unionSet:value_];
	[self didChangeValueForKey:@"pages" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value_];
}

-(void)removePages:(NSSet*)value_ {
	[self willChangeValueForKey:@"pages" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value_];
	[[self primitiveValueForKey:@"pages"] minusSet:value_];
	[self didChangeValueForKey:@"pages" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value_];
}
	
- (void)addPagesObject:(PageMO*)value_ {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value_ count:1];
	[self willChangeValueForKey:@"pages" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"pages"] addObject:value_];
	[self didChangeValueForKey:@"pages" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
	[changedObjects release];
}

- (void)removePagesObject:(PageMO*)value_ {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value_ count:1];
	[self willChangeValueForKey:@"pages" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[[self primitiveValueForKey:@"pages"] removeObject:value_];
	[self didChangeValueForKey:@"pages" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
	[changedObjects release];
}

- (NSMutableSet*)pagesSet {
	return [self mutableSetValueForKey:@"pages"];
}
	

@end
