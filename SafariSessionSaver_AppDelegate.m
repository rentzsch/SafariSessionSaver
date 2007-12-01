#import "SafariSessionSaver_AppDelegate.h"
#import "NSAppleScript+CallHandler.h"
#import "nsenumerate.h"
#import "CoreData+JRExtensions.h"
#import "SessionMO.h"
#import "PageMO.h"

@implementation SafariSessionSaver_AppDelegate

static void scriptErrorToNSError(NSDictionary *scriptError, NSError **nserror) {
	if (scriptError && nserror) {
		*nserror = [NSError errorWithDomain:NSCocoaErrorDomain
									   code:[[scriptError objectForKey:NSAppleScriptErrorNumber] intValue]
								   userInfo:scriptError];
	}
}

- (NSAppleScript*)safariSessionSaverScriptAndReturnError:(NSError**)error_ {
    NSURL           *scriptURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SafariSessionSaver"
                                                                                        ofType:@"scpt"
																				   inDirectory:@"Scripts"]];
	NSAssert(scriptURL, @"failed to load SafariSessionSaver.scpt");
	
	NSDictionary    *scriptError = nil;
    NSAppleScript   *script = [[[NSAppleScript alloc] initWithContentsOfURL:scriptURL
                                                                      error:&scriptError] autorelease];
	scriptErrorToNSError(scriptError, error_);
	return script;
}

- (IBAction)saveCurrentSafariSessionAction:(id)sender_ {
	NSError *error = nil;
	NSAppleScript *script = [self safariSessionSaverScriptAndReturnError:&error];

	NSDictionary			*scriptError = nil;
	NSAppleEventDescriptor	*scriptResultDesc = nil;
	if (!error) {
		scriptResultDesc = [script callHandler:@"current_safari_session"
						withArgumentDescriptor:nil
										 error:&scriptError];
		scriptErrorToNSError(scriptError, &error);
	}
	
	if (!error) {
		NSArray *urls = [[scriptResultDesc stringValue] componentsSeparatedByString:@"\t"];
		if ([urls count]) {
			NSManagedObjectContext *moc = [self managedObjectContext];
			SessionMO *session = [SessionMO newInManagedObjectContext:moc];
			nsenumerate(urls, NSString, url) {
				PageMO *page = [PageMO newInManagedObjectContext:moc];
				[page setUrl:url];
				[session addPagesObject:page];
			}
			[moc save:&error];
		}
	}
	
	if (error)
		[NSApp presentError:error];
}

- (IBAction)restoreAction:(id)sender_ {
	SessionMO *session = [[sessionArrayController selectedObjects] objectAtIndex:0];
	//NSAppleEventDescriptor  *urlList = [[[NSAppleEventDescriptor alloc] initListDescriptor] autorelease];
	NSMutableArray *urlList = [NSMutableArray arrayWithCapacity:[[session pagesSet] count]];
	nsenumerate([session pagesSet], PageMO, page) {
		/*[urlList insertDescriptor:[NSAppleEventDescriptor descriptorWithString:[page url]]
						  atIndex:[urlList numberOfItems]];*/
		[urlList addObject:[page url]];
	}
	NSString *urlListString = [urlList componentsJoinedByString:@"\r"];
	
#if 1
	NSError *error = nil;
	NSAppleScript *script = [self safariSessionSaverScriptAndReturnError:&error];
	
	NSDictionary	*scriptError = nil;
	if (!error) {
		[script callHandler:@"restore_safari_session" withArgumentArray:[NSArray arrayWithObject:urlListString] error:&scriptError];
		scriptErrorToNSError(scriptError, &error);
	}
	
	if (error)
		[NSApp presentError:error];
#endif
}

- (void)awakeFromNib {
    NSSortDescriptor * sd = [[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO] autorelease];
    // If executed immediately, an 'Unknown key in query. creationDate' exception is thrown.
    [sessionArrayController performSelector: @selector(setSortDescriptors:)
                          withObject:[NSArray arrayWithObject:sd]
                          afterDelay:0.0f];
}

//--


/**
    Returns the support folder for the application, used to store the Core Data
    store file.  This code uses a folder named "SafariSessionSaver" for
    the content, either in the NSApplicationSupportDirectory location or (if the
    former cannot be found), the system's temporary directory.
 */

- (NSString *)applicationSupportFolder {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"SafariSessionSaver"];
}


/**
    Creates, retains, and returns the managed object model for the application 
    by merging all of the models found in the application bundle and all of the 
    framework bundles.
 */
 
- (NSManagedObjectModel *)managedObjectModel {

    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
	
    NSMutableSet *allBundles = [[NSMutableSet alloc] init];
    [allBundles addObject: [NSBundle mainBundle]];
    [allBundles addObjectsFromArray: [NSBundle allFrameworks]];
    
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles: [allBundles allObjects]] retain];
    [allBundles release];
    
    return managedObjectModel;
}


/**
    Returns the persistent store coordinator for the application.  This 
    implementation will create and return a coordinator, having added the 
    store for the application to it.  (The folder for the store is created, 
    if necessary.)
 */

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {

    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }

    NSFileManager *fileManager;
    NSString *applicationSupportFolder = nil;
    NSURL *url;
    NSError *error;
    
    fileManager = [NSFileManager defaultManager];
    applicationSupportFolder = [self applicationSupportFolder];
    if ( ![fileManager fileExistsAtPath:applicationSupportFolder isDirectory:NULL] ) {
        [fileManager createDirectoryAtPath:applicationSupportFolder attributes:nil];
    }
    
    url = [NSURL fileURLWithPath: [applicationSupportFolder stringByAppendingPathComponent: @"SafariSessionSaver.xml"]];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]){
        [[NSApplication sharedApplication] presentError:error];
    }    

    return persistentStoreCoordinator;
}


/**
    Returns the managed object context for the application (which is already
    bound to the persistent store coordinator for the application.) 
 */
 
- (NSManagedObjectContext *) managedObjectContext {

    if (managedObjectContext != nil) {
        return managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}


/**
    Returns the NSUndoManager for the application.  In this case, the manager
    returned is that of the managed object context for the application.
 */
 
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    return [[self managedObjectContext] undoManager];
}


/**
    Performs the save action for the application, which is to send the save:
    message to the application's managed object context.  Any encountered errors
    are presented to the user.
 */
 
- (IBAction) saveAction:(id)sender {

    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}


/**
    Implementation of the applicationShouldTerminate: method, used here to
    handle the saving of changes in the application managed object context
    before the application terminates.
 */
 
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {

    NSError *error;
    int reply = NSTerminateNow;
    
    if (managedObjectContext != nil) {
        if ([managedObjectContext commitEditing]) {
            if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
				
                // This error handling simply presents error information in a panel with an 
                // "Ok" button, which does not include any attempt at error recovery (meaning, 
                // attempting to fix the error.)  As a result, this implementation will 
                // present the information to the user and then follow up with a panel asking 
                // if the user wishes to "Quit Anyway", without saving the changes.

                // Typically, this process should be altered to include application-specific 
                // recovery steps.  

                BOOL errorResult = [[NSApplication sharedApplication] presentError:error];
				
                if (errorResult == YES) {
                    reply = NSTerminateCancel;
                } 

                else {
					
                    int alertReturn = NSRunAlertPanel(nil, @"Could not save changes while quitting. Quit anyway?" , @"Quit anyway", @"Cancel", nil);
                    if (alertReturn == NSAlertAlternateReturn) {
                        reply = NSTerminateCancel;	
                    }
                }
            }
        } 
        
        else {
            reply = NSTerminateCancel;
        }
    }
    
    return reply;
}


/**
    Implementation of dealloc, to release the retained variables.
 */
 
- (void) dealloc {

    [managedObjectContext release], managedObjectContext = nil;
    [persistentStoreCoordinator release], persistentStoreCoordinator = nil;
    [managedObjectModel release], managedObjectModel = nil;
    [super dealloc];
}


@end
