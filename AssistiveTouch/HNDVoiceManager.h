/**
 * This header is generated by class-dump-z 0.2b.
 *
 * Source: (null)
 */

#import "ATLVoiceParserDelegate.h"

@class NSMutableDictionary, HNDAXElement, ATLVoiceParser, AXTimer;

__attribute__((visibility("hidden")))
@interface HNDVoiceManager <ATLVoiceParserDelegate> {
	ATLVoiceParser* _parser;
	NSMutableDictionary* _dispatchTable;
	AXTimer* _screenChangeTimer;
	HNDAXElement* _currentApplication;
}
+(id)sharedManager;
+(void)initialize;
-(BOOL)_pressHomeButton:(id)button;
-(BOOL)_toggleRinger:(id)ringer;
-(BOOL)_setVolume:(id)volume;
-(BOOL)_pressVolumeDown:(id)down;
-(BOOL)_pressVolumeUp:(id)up;
-(BOOL)_pressLockButton:(id)button;
-(BOOL)_siriStart:(id)start;
-(BOOL)_dictationStart:(id)start;
-(BOOL)_escape:(id)escape;
-(BOOL)_appSwitcher:(id)switcher;
-(BOOL)_openApplicationCommand:(id)command;
-(void)voiceParser:(id)parser didDetectCommand:(id)command;
-(void)handleScreenChange;
-(void)handleFirstResponderChanged;
-(void)_updateDomains;
-(void)_updateDomainsForTextEditing;
-(void)_updateDomainsForBundleId:(id)bundleId;
-(void)stopListening;
-(void)startListening;
-(void)removeAllDomains;
-(void)removeDomain:(id)domain;
-(void)addDomain:(id)domain;
-(id)parser;
-(void)dealloc;
-(id)init;
-(void)_initializeDispatchTable;
@end

