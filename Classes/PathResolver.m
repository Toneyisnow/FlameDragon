#import "PathResolver.h"

@implementation PathResolver

-(id) initWithMap:(FDIntMap *)map Width:(int)w Height:(int)h
{
	self = [super init];
	
	blockMap = map;
	width = w;
	height = h;
	
	linkedPos = [[FDPointMap alloc] initWidth:width Height:height];
	positionQueue = [[NSMutableArray alloc] init];
	
	return self;
}

-(FDPath *) resolvePathFrom:(CGPoint)pos To:(CGPoint)target MaxStep:(int)step
{
	maxStep = step;
	targetPos = target;
	
	[linkedPos setX:pos.x Y:pos.y Value:pos];
	
	[positionQueue addObject:[FDPosition positionX:pos.x Y:pos.y]];
	while([positionQueue count] > 0)
	{
		FDPosition *pos = [positionQueue objectAtIndex:0];

		[self walk:pos Step:step];
		//CGPoint linked = [linkedPos getX:[pos x] Y:[pos y]];
		// NSLog(@"Walk pos x=%d y=%d     linked to x=%f y=%f", [pos x], [pos y], linked.x, linked.y);
		
		[positionQueue removeObject:pos];
	}
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	int nowX = target.x;
	int nowY = target.y;
	[array addObject:[FDPosition positionX:nowX Y:nowY]];
	
	while (!(pos.x == nowX && pos.y == nowY) && !(nowX == 0 && nowY == 0)) {
		
		CGPoint p = [linkedPos getX:nowX Y:nowY];
		nowX = p.x;
		nowY = p.y;
		[array addObject:[FDPosition positionX:nowX Y:nowY]];
	}
	
	FDPath *path = [[FDPath alloc] init];
	
	for (int i = [array count]-1; i >= 0; i--) {
		[path addPos:[array objectAtIndex:i]];
	}
	
	[array release];
	
	return [path autorelease];
}

-(void) walk:(FDPosition *)pos Step:(int)step
{
	
	int posX = [pos x];
	int posY = [pos y];
	
	// Find the target
	if (targetPos.x == posX && targetPos.y == posY) {
		[positionQueue removeAllObjects];
		return;
	}
	
	int i = 1;
	while([self canWalkX:posX-i Y:posY Step:step-i])
	{
		[linkedPos setX:posX-i Y:posY Value:CGPointMake(posX, posY)];
		[positionQueue addObject:[FDPosition positionX:posX-i Y:posY]];
		i++;
	}
	i = 1;
	while([self canWalkX:posX+i Y:posY Step:step-i])
	{
		[linkedPos setX:posX+i Y:posY Value:CGPointMake(posX, posY)];
		[positionQueue addObject:[FDPosition positionX:posX+i Y:posY]];
		i++;
	}	 
	
	i = 1;
	while([self canWalkX:posX Y:posY-i Step:step-i])
	{
		[linkedPos setX:posX Y:posY-i Value:CGPointMake(posX, posY)];
		[positionQueue addObject:[FDPosition positionX:posX Y:posY-i]];
		i++;
	}
	i = 1;
	while([self canWalkX:posX Y:posY+1 Step:step-i])
	{
		[linkedPos setX:posX Y:posY+1 Value:CGPointMake(posX, posY)];
		[positionQueue addObject:[FDPosition positionX:posX Y:posY+i]];
		i++;
	}
}

-(bool) canWalkX:(int)posX Y:(int)posY Step:(int)step
{
	if (step < 0) {
		return FALSE;
	}
	
	if (posX <= 0 || posX > width || posY <= 0 || posY > height)
	{
		return FALSE;
	}
	
	if ([blockMap getX:posX Y:posY] != 0)
	{
		return FALSE;
	}
	
	if(![FDPosition isEqual:[linkedPos getX:posX Y:posY] With:CGPointMake(0, 0)])
	{
		return FALSE;
	}

	return TRUE;
}


-(void) dealloc
{
	[linkedPos release];
	[positionQueue release];
	
	[super dealloc];
}

@end
