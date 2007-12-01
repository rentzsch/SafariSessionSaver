#import <Cocoa/Cocoa.h>

@interface NSAppleScript (CallHandler)

- (NSAppleEventDescriptor*)callHandler:(NSString*)handler
                withArgumentDescriptor:(NSAppleEventDescriptor*)arguments
                                 error:(NSDictionary**)error;

- (NSAppleEventDescriptor*)callHandler:(NSString*)handler
                     withArgumentArray:(NSArray*)arguments
                                 error:(NSDictionary**)error;

@end