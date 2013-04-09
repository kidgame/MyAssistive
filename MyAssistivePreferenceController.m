#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>

__attribute__((visibility("hidden")))
@interface MyAssistivePreferenceController : PSListController
- (id)specifiers;
@end

@implementation MyAssistivePreferenceController

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"MyAssistive" target:self] retain];
  }
	return _specifiers;
}

- (void)enterPastebin:(id)param
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://pastebin.com/BVum4cga"]];
}

@end
