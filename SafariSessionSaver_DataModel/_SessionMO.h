// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SessionMO.h instead.

#import <CoreData/CoreData.h>


@class PageMO;

@interface SessionMOID : NSManagedObjectID {}
@end

@interface _SessionMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SessionMOID*)objectID;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *creationDate;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* pages;
- (NSMutableSet*)pagesSet;



@end

@interface _SessionMO (CoreDataGeneratedAccessors)

- (void)addPages:(NSSet*)value_;
- (void)removePages:(NSSet*)value_;
- (void)addPagesObject:(PageMO*)value_;
- (void)removePagesObject:(PageMO*)value_;

@end
