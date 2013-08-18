#import "ScopeResolver.h"

@implementation ScopeResolver

-(id) initWithMap:(FDIntMap *)map Width:(int)w Height:(int)h
{
	self = [super init];
	
	resistanceMap = [map retain];
	width = w;
	height = h;
	
	walkedMap = [[FDIntMap alloc] initWidth:w Height:h];
	
	//int[] blocks[width*height];
	//walkedMap = blocks;
	
	return self;
}

-(NSMutableArray *) resolveScopeFrom:(CGPoint)pos min:(int)min max:(int)movePoint	// Array of
{
    return [self resolveScopeFrom:pos min:min max:movePoint isCross:FALSE];
}

-(NSMutableArray *) resolveScopeFrom:(CGPoint)pos min:(int)min max:(int)movePoint isCross:(BOOL)isCross			// Array of FDPosition
{
	// Since the following reason, the movement should +1: 
	// For movement = 5, the steps should be 
	[self walk:pos WithMovePoint:movePoint+1];
	
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for(int i = 1; i <= width; i++)
		for(int j = 1; j <= height; j++)
		{
			if ([walkedMap getX:i Y:j] > 0 && [walkedMap getX:i Y:j] <= movePoint + 1 - min && [resistanceMap getX:i Y:j] >= 0)		// resistance < 0 means it should be skipped/jumped
			{
                if (!isCross || i == pos.x || j == pos.y) {
                    [result addObject:[FDPosition positionX:i Y:j]];
                }
			}
		}
	
	CCLOG(@"Resolved Result count: %d", [result count]);
	return [result autorelease];
}

-(void) walk:(CGPoint) pos WithMovePoint:(int)nowPoint
{
	// CCLOG(@"Walk Pos: %f, %f  point:%d", pos.x, pos.y, nowPoint);
	
	if (nowPoint <= 0)
	{
		return;
	}
	
	if (pos.x <= 0 || pos.x > width || pos.y <= 0 || pos.y > height)
	{
		return;
	}
	
	if ([walkedMap getX:pos.x Y:pos.y] >= nowPoint || nowPoint <= 0)
	{
		return;
	}
	
	// Then update this walk map
	if ([resistanceMap getX:pos.x Y:pos.y] > 0) {
		[walkedMap setX:pos.x Y:pos.y Value:nowPoint];
	}
	
	int leftPoint = nowPoint - abs([resistanceMap getX:pos.x Y:pos.y]);
	
	// CCLOG(@"Set walked Map: x=%f y=%f value:%d", pos.x, pos.y, leftPoint);
	
	//[self setWalkedMapX:pos.x Y:pos.y Value:nowPoint];
	
	[self walk:CGPointMake(pos.x, pos.y-1) WithMovePoint:leftPoint];
	[self walk:CGPointMake(pos.x, pos.y+1) WithMovePoint:leftPoint];
	[self walk:CGPointMake(pos.x-1, pos.y) WithMovePoint:leftPoint];
	[self walk:CGPointMake(pos.x+1, pos.y) WithMovePoint:leftPoint];
}

/*
-(int) resistanceX:(int)x Y:(int)y
{
	if x <= 0 || x > width || y <= 0 || y > height)
	{
		return 0;
	}
	
	return resistanceMap[(x-1) * height + y - 1];
}

-(int) walkedMapX:(int)x Y:(int)y
{
	if (x <= 0 || x > width || y <= 0 || y > height)
	{
		return 0;
	}

	return walkedMap[(x-1) * height + y - 1];
}

-(void) setWalkedMapX:(int)x Y:(int)y Value:(int)val
{
	if (x <= 0 || x > width || y <= 0 || y > height)
	{
		return;
	}
	
	walkedMap[(x-1) * height + y - 1] = val;
}
*/

-(void) dealloc
{
	[walkedMap release];
	[resistanceMap release];
	
	[super dealloc];
}


@end
