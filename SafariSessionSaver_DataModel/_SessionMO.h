// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SessionMO.h instead.

#import <CoreData/CoreData.h>



@class PageMO;


@interface _SessionMO : NSManagedObject {}


- (NSString*)name;
- (void)setName:(NSString*)value_;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



- (NSDate*)creationDate;
- (void)setCreationDate:(NSDate*)value_;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;




- (void)addPages:(NSSet*)value_;
- (void)removePages:(NSSet*)value_;
- (void)addPagesObject:(PageMO*)value_;
- (void)removePagesObject:(PageMO*)value_;
- (NSMutableSet*)pagesSet;


@end
