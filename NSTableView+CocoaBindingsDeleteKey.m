#import <Cocoa/Cocoa.h>

@interface NSTableViewPlusCocoaBindingsDeleteKey : NSTableView {}
@end
@implementation NSTableViewPlusCocoaBindingsDeleteKey
+ (void)load {
	[NSTableViewPlusCocoaBindingsDeleteKey poseAsClass:[NSTableView class]];
}

- (void)keyDown:(NSEvent*)event_ {
	NSString *eventCharacters = [event_ characters];
	if ([eventCharacters length]) {
		switch ([eventCharacters characterAtIndex:0]) {
			case NSDeleteFunctionKey:
			case NSDeleteCharFunctionKey:
			case NSDeleteCharacter: {
				NSArray *columns = [self tableColumns];
				unsigned columnIndex = 0, columnCount = [columns count];
				NSDictionary *valueBindingDict = nil;
				for (; !valueBindingDict && columnIndex < columnCount; ++columnIndex) {
					valueBindingDict = [[columns objectAtIndex:columnIndex] infoForBinding:@"value"];
				}
				if (valueBindingDict && [[valueBindingDict objectForKey:@"NSObservedObject"] isKindOfClass:[NSArrayController class]]) {
					//	Found a column bound to an array controller.
					[[valueBindingDict objectForKey:@"NSObservedObject"] remove:self];
				} else {
					[super keyDown:event_];
				}
			} break;
			default:
				[super keyDown:event_];
				break;
		}
	}
}

@end
