#import "NSAppleScript+CallHandler.h"
#include <Carbon/Carbon.h>

@implementation NSAppleScript (CallHandler)

- (NSAppleEventDescriptor*)callHandler:(NSString*)handler
                withArgumentDescriptor:(NSAppleEventDescriptor*)arguments
                                 error:(NSDictionary**)error
{
    //  Target our own process.
    ProcessSerialNumber currentProcess = { 0, kCurrentProcess };
    NSAppleEventDescriptor *targetAddress = [[[NSAppleEventDescriptor alloc] initWithDescriptorType:typeProcessSerialNumber
                                                                                              bytes:&currentProcess
                                                                                             length:sizeof(currentProcess)] autorelease];
    //  Create the event.
    NSAppleEventDescriptor *event = [[[NSAppleEventDescriptor alloc] initWithEventClass:typeAppleScript
                                                                                eventID:kASSubroutineEvent
                                                                       targetDescriptor:targetAddress
                                                                               returnID:kAutoGenerateReturnID
                                                                          transactionID:kAnyTransactionID] autorelease];
    //  Set the handler's name.
    [event setParamDescriptor:[NSAppleEventDescriptor descriptorWithString:handler]
                   forKeyword:keyASSubroutineName];
    
    //  Add the arguments.
	if (arguments) {
		[event setParamDescriptor:arguments
					   forKeyword:keyDirectObject];
	}
    
    //  Execute the handler.
    return [self executeAppleEvent:event error:error];
}

- (NSAppleEventDescriptor*)callHandler:(NSString*)handler
                     withArgumentArray:(NSArray*)arguments
                                 error:(NSDictionary**)error
{
    NSAppleEventDescriptor  *argDesc = [[[NSAppleEventDescriptor alloc] initListDescriptor] autorelease];
    
    int argIndex = 0, argCount = [arguments count];
    for( ; argIndex < argCount; ++argIndex ) {
        [argDesc insertDescriptor:[NSAppleEventDescriptor descriptorWithString:[arguments objectAtIndex:argIndex]]
                          atIndex:argIndex+1]; // One-based index.
    }
    return [self callHandler:handler withArgumentDescriptor:argDesc error:error];
}

@end