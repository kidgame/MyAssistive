/**
 * This header is generated by class-dump-z 0.2b.
 *
 * Source: (null)
 */

#import "assistivetouchd-Structs.h"


__attribute__((visibility("hidden")))
@interface HNDHoverCursorMark {
	CGAffineTransform _rotationTransform;
	CGRect _originalFrame;
}
@property(assign, nonatomic) CGRect originalFrame;
@property(assign, nonatomic) CGAffineTransform rotationTransform;
-(void)drawRect:(CGRect)rect;
-(void)setFrame:(CGRect)frame;
-(id)initWithFrame:(CGRect)frame;
@end

