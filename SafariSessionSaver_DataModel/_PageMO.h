// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PageMO.h instead.

#import <CoreData/CoreData.h>


@class SessionMO;

@interface PageMOID : NSManagedObjectID {}
@end

@interface _PageMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PageMOID*)objectID;



@property (nonatomic, retain) NSString *url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) SessionMO* newRelationship;
//- (BOOL)validateNewRelationship:(id*)value_ error:(NSError**)error_;



@end

@interface _PageMO (CoreDataGeneratedAccessors)

@end
