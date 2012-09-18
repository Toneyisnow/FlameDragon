#import "cocos2d.h"
#import "FDPath.h"
#import "FDPosition.h"
#import "FDIntMap.h"

typedef enum ScopeResistanceType
{
	// <0 mean that the block cannot be standed on, the value means the step resistance after walk across the block
	
	ScopeResistance_Plain = 1,
	ScopeResistance_Slow = 2,
	ScopeResistance_Gap = -99,
	ScopeResistance_Skip = -1,
	ScopeResistance_ZOC = 99	// Currently it's not working
	
} ScopeResistanceType;

@interface ScopeResolver : NSObject
{
	FDIntMap *resistanceMap;

	int width;
	int height;
	
	FDIntMap* walkedMap;
	
}

-(id) initWithMap:(FDIntMap *)map Width:(int)w Height:(int)h;

-(NSMutableArray *) resolveScopeFrom:(CGPoint)pos min:(int)min max:(int)movePoint;		// Array of FDPosition

-(void) walk:(CGPoint) pos WithMovePoint:(int)nowPoint;

//-(int) resistanceX:(int)x Y:(int)y;
//-(int) walkedMapX:(int)x Y:(int)y;
//-(void) setWalkedMapX:(int)x Y:(int)y Value:(int)val;

@end
