#import <Cocoa/Cocoa.h>

@interface SafariSessionSaver_AppDelegate : NSObject 
{
    IBOutlet NSWindow			*window;
	IBOutlet NSArrayController	*sessionArrayController;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (IBAction)saveAction:sender;
- (IBAction)saveCurrentSafariSessionAction:(id)sender_;
- (IBAction)restoreAction:(id)sender_;

@end
