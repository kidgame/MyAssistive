#import "substrate.h"
#import <UIKit/UIKit.h>
#import <GraphicsServices/GSEvent.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AVFoundation/AVFoundation.h>
#import "AssistiveTouch/HNDEventManager.h"
#import "AssistiveTouch/HNDDisplayManager.h"
#import "AssistiveTouch/HNDRocker.h"
#import "AssistiveTouch/HNDRockerButton.h"
#import <SpringBoard/SpringBoard.h>
#import <notify.h>

static BOOL ReplaceEnabled;
static BOOL NoLockPosEnabled;
static BOOL NoHideSSEnabled;
static BOOL BlueIconEnabled;

float xPos;
CGPoint nubbitPos;
int MyNumber;
struct GSEventRecord record;
static int orientation;
BOOL torchIsOn;

@interface BKSWorkspace : NSObject
- (id)init;
- (void)_sendShutdown:(BOOL)arg1;
- (void)shutdown:(BOOL)arg1;
@end

#define HNDController [%c(HNDEventManager) sharedManager]

// Return control to system, also fix NC crashing
void RTS () {
	HNDRocker *cont = [[%c(HNDRocker) alloc] init];
	[cont transitionMenuToNubbit:nubbitPos changeAlpha:0 animate:0];
	[HNDController manipulateDimTimer:NO];
}

static void Inject () {
AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
BKSWorkspace *BackBoardController = [[%c(BKSWorkspace) alloc] init];
	switch (MyNumber) {
	case 1 :
		break;
	case 2 :
		[HNDController _toggleAppSwitcher];
		break;
	case 3 :
		[HNDController _toggleSiri];
		break;
	case 4 :
		[HNDController _toggleVoiceControl];
		break;
	case 5 :		
		[HNDController _takeScreenshot];
		break;
	case 6 :
		[HNDController _tripleClick];
		break;
	case 7 :
		if (xPos < 160.0f) {
			[HNDController performHardwareButton:3 state:2];
			[HNDController performHardwareButton:3 state:3];
			break;
		}
		else {
			[HNDController performHardwareButton:4 state:2];
			[HNDController performHardwareButton:4 state:3];
			break;
		}
	case 8 :
		if (xPos < 160.0f) {
			[HNDController performHardwareButton:5 state:1];
			break;
		}
		else {
			[HNDController performHardwareButton:6 state:1];
			break;
		}
	case 9 :
		system("killall SpringBoard");
		break;
	case 10 :
		notify_post("com.ps.reboot"); // For SBSettings
		[BackBoardController shutdown:YES]; // For BackBoard access
		[BackBoardController _sendShutdown:YES];
		break;
	case 11 :
		notify_post("com.ps.halt"); // For SBSettings
		[BackBoardController shutdown:NO]; // For BackBoard access
		[BackBoardController _sendShutdown:NO];
		break;
	case 12 :
		memset(&record, 0, sizeof(record));
		record.type = kGSEventLockButtonDown;
		record.timestamp = GSCurrentEventTimestamp();
		GSSendSystemEvent(&record);
		record.type = kGSEventLockButtonUp;
		GSSendSystemEvent(&record);
		break;
	case 13 :
		[HNDController performHardwareButton:1 state:2];
		[HNDController performHardwareButton:1 state:3];
		break;
	case 14 :
		GSEventQuitTopApplication();
		break;
	case 15 :
		GSEventLockDevice();
		break;
	case 16 :
		// CW (1 - 3 - 2 - 4)
		if (orientation == 1) {
			[HNDController _sendDeviceOrientationChange:3];
			break;
		}
		else if (orientation == 3) {
			[HNDController _sendDeviceOrientationChange:2];
			break;
		}
		else if (orientation == 2) {
			[HNDController _sendDeviceOrientationChange:4];
			break;
		}
		else if (orientation == 4) {
			[HNDController _sendDeviceOrientationChange:1];
			break;
		}
		else {
			NSLog(@"Error: Cannot detect orientation");
			break;
		}
	case 17 :
		// CCW (1 - 4 - 2 - 3)
		if (orientation == 1) {
			[HNDController _sendDeviceOrientationChange:4];
			break;
		}
		else if (orientation == 4) {
			[HNDController _sendDeviceOrientationChange:2];
			break;
		}
		else if (orientation == 2) {
			[HNDController _sendDeviceOrientationChange:3];
			break;
		}
		else if (orientation == 3) {
			[HNDController _sendDeviceOrientationChange:1];
			break;
		}
		else {
			NSLog(@"Error: Cannot detect orientation");
			break;
		}
	case 18 :
		if ([device hasTorch]) {
			if (device.torchLevel > 0.0) torchIsOn = YES; 
    		else if (device.torchLevel == 0.0) torchIsOn = NO;
    				if (!torchIsOn) {
        				torchIsOn = YES;
    					[device lockForConfiguration:nil];
        				[device setTorchMode:AVCaptureTorchModeOn];
           				[device unlockForConfiguration]; break; }
  					else if (torchIsOn) {
  						[device lockForConfiguration:nil];
       					[device setTorchMode:AVCaptureTorchModeOff];
       					[device unlockForConfiguration];
        				torchIsOn = NO;	break; }
   		} else {
   			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This iDevice doesn't supported Torch." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
			[alert show];
			[alert release]; break; }
	case 19 :
		system("killall -SEGV SpringBoard");
		break;
	}
}

%hook HNDEventManager

- (int)deviceOrientation
{
	return (orientation = %orig);
}

%end

%hook HNDDisplayManager

- (void)_handleNubbitMove:(CGPoint)move { %orig; CGPoint pos = move; xPos = pos.x; }

- (void)_moveNubbitToPosition:(CGPoint)arg1 { if (NoLockPosEnabled); else if (!NoLockPosEnabled) %orig; else %orig; }

- (void)viewPressed:(id)pressed
{
	if (ReplaceEnabled) {
		Inject();
		if (MyNumber == 1) %orig; else RTS();
	}
	else %orig;
}

%end

%hook HNDHandManager

- (void)screenshotWillFire { if (NoHideSSEnabled); else if (!NoHideSSEnabled) %orig; else %orig; }

%end

%hook HNDRocker

- (void)transitionMenuToNubbit:(CGPoint)nubbit changeAlpha:(BOOL)alpha animate:(BOOL)animate
{
	nubbitPos = nubbit;
	%orig;
}

%end

%hook HNDRockerButton

- (BOOL)selected { if (BlueIconEnabled) return YES; else return %orig; }

%end

static void loadPreferences()
{
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.PS.MyAssistive.plist"];
	id replaceenabled = [dict objectForKey:@"replaceEnabled"];
	id nolockposenabled = [dict objectForKey:@"noLockPosEnabled"];
	id nohidessenabled = [dict objectForKey:@"noHideSSEnabled"];
	id blueiconenabled = [dict objectForKey:@"blueIconEnabled"];
	ReplaceEnabled = replaceenabled ? [replaceenabled boolValue] : YES;
	NoLockPosEnabled = nolockposenabled ? [nolockposenabled boolValue] : YES;
	NoHideSSEnabled = nohidessenabled ? [nohidessenabled boolValue] : YES;
	BlueIconEnabled = blueiconenabled ? [blueiconenabled boolValue] : YES;
	int readMyNumber = [dict objectForKey:@"myNumber"] ? [[dict objectForKey:@"myNumber"] integerValue] : 1;
	if (readMyNumber < 1 || readMyNumber > 20)
		readMyNumber = 1;
	if (readMyNumber != MyNumber)
		MyNumber = readMyNumber;
}

static void PostNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	loadPreferences();
}

%ctor {
   NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, PostNotification, CFSTR("com.PS.MyAssistive.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	loadPreferences();
	[pool drain];
	%init
}