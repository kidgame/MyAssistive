/**
 * This header is generated by class-dump-z 0.2b.
 *
 * Source: (null)
 */


@class NSArray, NSString;

__attribute__((visibility("hidden")))
@interface HNDCustomGesture {
	NSString* name;
	NSArray* points;
	NSArray* times;
}
@property(retain, nonatomic) NSArray* times;
@property(retain, nonatomic) NSArray* points;
@property(retain, nonatomic) NSString* name;
+(id)gestureWithDictionary:(id)dictionary;
-(id)_initWithDictionary:(id)dictionary;
@end

