/**
 * This header is generated by class-dump-z 0.2b.
 *
 * Source: (null)
 */

#import "assistivetouchd-Structs.h"

@class UIView;

__attribute__((visibility("hidden")))
@interface HNDHoverCursorCircle {
	BOOL _fill;
	BOOL _dashed;
	BOOL _selected;
	UIView* _innerCircle;
	float _radiusMultiplier;
}
@property(readonly, assign, nonatomic) float radius;
@property(assign, nonatomic) float radiusMultiplier;
@property(assign, nonatomic) BOOL selected;
@property(assign, nonatomic) BOOL dashed;
@property(assign, nonatomic) BOOL fill;
-(void)drawRect:(CGRect)rect;
-(void)showInnerCircle:(BOOL)circle;
-(id)initWithFrame:(CGRect)frame;
@end

