#import "cocos2d.h"
#import "FDPath.h"
#import "FDPosition.h"
#import "FDPointMap.h"
#import "FDIntMap.h"

typedef enum PathBlockType
{
	PathBlockType_Plain = 0,
	PathBlockType_Blocked = 1
	
} PathBlockType;

@interface PathResolver : NSObject
{

	FDIntMap *blockMap;

	int width;
	int height;
	
	int maxStep;
	
	FDPointMap *linkedPos;
	NSMutableArray *positionQueue;
	
	CGPoint targetPos;
}

-(id) initWithMap:(FDIntMap *)map Width:(int)w Height:(int)h;

-(FDPath *) resolvePathFrom:(CGPoint)pos To:(CGPoint)target MaxStep:(int)step;

-(void) walk:(FDPosition *)pos Step:(int)step;
-(bool) canWalkX:(int)posX Y:(int)posY Step:(int)step;

//-(FDPath *) fillPathWithAllPoints:(FDPath *)path;


@end
