#import "DistanceResolver.h"
#import "Common.h"

@implementation DistanceResolver

-(id) initWithMap:(FDIntMap *)map Width:(int)w Height:(int)h
{
	self = [super init];
	
	blockMap = [map retain];
	width = w;
	height = h;
	
	originPos = CGPointMake(0, 0);
	distanceDic = nil;
	
	posQueue = nil;
	
	return self;
}

-(NSDictionary *) resolveDistanceFrom:(CGPoint)pos terminateAt:(CGPoint)terminatePos
{
	if (distanceDic == nil || ![FDPosition isEqual:pos With:originPos]) {
		
		if (distanceDic != nil) {
			[distanceDic release];
			distanceDic = nil;
		}
		
		distanceDic = [[NSMutableDictionary alloc] init];		
		posQueue = [[NSMutableArray alloc] init];

		// Init
		[self setKey:pos Value:0];
		
		while ([posQueue count] > 0) {
			
			[self walk:[posQueue objectAtIndex:0]];
			
			FDPosition *lastPos = [posQueue objectAtIndex:0];
			if ([lastPos x] == terminatePos.x && [lastPos y] == terminatePos.y) {
				break;
			}
			[posQueue removeObjectAtIndex:0];
		}
	}
	
	return distanceDic;
}

-(float) getDistanceTo:(CGPoint)pos
{
	if (distanceDic == nil) {
		NSLog(@"Cannot get distance, distanceDic is nil. Should call resolveDistanceFrom first.");
		return 0;
	}
	
	FDPosition *posObj = [FDPosition positionX:pos.x Y:pos.y];
	NSNumber *valObj = [distanceDic objectForKey:[posObj hashKey]];
	
	if (valObj == nil) {
		
		// Distance Max
		return 999;
	}
	
	return [valObj floatValue];
}

-(float) getHeristicValue:(CGPoint)pos toTarget:(CGPoint)target {
    
    return [Common getAbs:(pos.x-target.x)]+[Common getAbs:(pos.y-target.y)];
}

-(float) resolveDistanceFrom:(CGPoint)oPos To:(CGPoint)tPos
{
	[self resolveDistanceFrom:oPos terminateAt:tPos];
	
	return [self getDistanceTo:tPos];
}

-(void) walk:(FDPosition *)pos
{
	// NSLog(@"Walk Pos :(%d, %d)", [pos x], [pos y]);
	
	
	NSNumber *valObj = [distanceDic objectForKey:[pos hashKey]];
	if (valObj == nil) {
		return;
	}
	
	float val = [valObj floatValue];
	
	[self setKey:CGPointMake(pos.x-1, pos.y) Value:val+1];
	[self setKey:CGPointMake(pos.x, pos.y-1) Value:val+1];
	[self setKey:CGPointMake(pos.x+1, pos.y) Value:val+1];
	[self setKey:CGPointMake(pos.x, pos.y+1) Value:val+1];
	
	[self setKey:CGPointMake(pos.x-1, pos.y-1) Value:val+1.4];
	[self setKey:CGPointMake(pos.x+1, pos.y-1) Value:val+1.4];
	[self setKey:CGPointMake(pos.x-1, pos.y+1) Value:val+1.4];
	[self setKey:CGPointMake(pos.x+1, pos.y+1) Value:val+1.4];

}

-(void) setKey:(CGPoint)pos Value:(float)val
{
	if (pos.x <= 0 || pos.x > width || pos.y <= 0 || pos.y > height) {
		return;
	}
	
	FDPosition *nowPos = [FDPosition positionX:pos.x Y:pos.y];
	[nowPos retain];
	
	if ([distanceDic objectForKey:[nowPos hashKey]] != nil) {
		NSNumber *lastValue = [distanceDic objectForKey:[nowPos hashKey]];
		if ([lastValue floatValue] <= val)
		{
			return;
		}
	}
	
	[distanceDic setObject:[NSNumber numberWithFloat:val] forKey:[nowPos hashKey]];
	[posQueue addObject:nowPos];
	
	[nowPos autorelease];
}

-(void) dealloc
{
	[blockMap release];
	[distanceDic release];
	[posQueue release];
	
	[super dealloc];
}

@end
