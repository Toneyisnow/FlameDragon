//
//  FDMoveToActivity.m
//  FlameDragon
//
//  Created by sui toney on 11-11-6.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDMoveCreatureActivity.h"


@implementation FDMoveCreatureActivity

-(id) initWithObject:(FDCreature *)obj ToLocation:(CGPoint)loc Speed:(float)s
{
	self = [super init];
	
	creature = obj;
	targetLocation = loc;
	speed = s;
	
	return self;
}

-(void) initialize
{
	CGPoint original = [[creature getSprite] location];
	
	if (original.x < targetLocation.x) {
		// Moving right
		[creature setGestureStatus:GestureStatus_MovingRight];
		dx = 1;
		dy = 0;
	}
	else if (original.x > targetLocation.x) {
		// Moving left
		[creature setGestureStatus:GestureStatus_MovingLeft];
		dx = -1;
		dy = 0;
	}
	else if (original.y < targetLocation.y) {
		// Moving up
		[creature setGestureStatus:GestureStatus_MovingUp];
		dx = 0;
		dy = 1;
	}
	else if (original.y > targetLocation.y) {
		// Moving down
		[creature setGestureStatus:GestureStatus_MovingDown];
		dx = 0;
		dy = -1;
	}
}

-(void) mainTick:(int)synchronizeTick
{
	CGPoint current = [[creature getSprite] location];
	
	float resultX = current.x + dx * speed;
	float resultY = current.y + dy * speed;
	
	if ((resultX - targetLocation.x) * (current.x - targetLocation.x) < 0
		|| (resultY - targetLocation.y) * (current.y - targetLocation.y) < 0
		|| (resultX == targetLocation.x && resultY == targetLocation.y)) {
		
		hasFinished = TRUE;
		resultX = targetLocation.x;
		resultY = targetLocation.y;
		
		[creature setGestureStatus:GestureStatus_Idle];
	}
	
	[creature setLocation:CGPointMake(resultX, resultY)];
}


@end
