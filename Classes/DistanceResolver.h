#import "cocos2d.h"
#import "FDPath.h"
#import "FDPosition.h"
#import "FDPointMap.h"
#import "FDIntMap.h"

@interface DistanceResolver : NSObject
{
	FDIntMap *blockMap;
	int width;
	int height;
	CGPoint originPos;
	
	NSMutableDictionary *distanceDic;
	NSMutableArray *posQueue;
}

-(id) initWithMap:(FDIntMap *)map Width:(int)w Height:(int)h;

-(NSDictionary *) resolveDistanceFrom:(CGPoint)pos terminateAt:(CGPoint)termi;
-(float) getDistanceTo:(CGPoint)pos;
-(float) resolveDistanceFrom:(CGPoint)oPos To:(CGPoint)tPos;


-(void) walk:(FDPosition *)pos;
-(void) setKey:(CGPoint)pos Value:(float)val;

//-(FDPath *) fillPathWithAllPoints:(FDPath *)path;


@end
