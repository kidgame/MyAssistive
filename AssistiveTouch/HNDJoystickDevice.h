/**
 * This header is generated by class-dump-z 0.2b.
 *
 * Source: (null)
 */

#import "HNDDevice.h"

@class AXTimer;

__attribute__((visibility("hidden")))
@interface HNDJoystickDevice : HNDDevice {
	AXTimer* _repeatTimer;
}
-(void)handleReportCallback:(int)callback report:(char*)report reportLength:(long)length;
-(void)dealloc;
@end

