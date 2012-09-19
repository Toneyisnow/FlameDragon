//
//  AIDelegate.m
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "AIDelegate.h"
#import "FDPointMap.h"
#import "FDPath.h"
#import "FDIntMap.h"
#import "GroundBlock.h"
#import "PathResolver.h"
#import "ScopeResolver.h"
#import "DistanceResolver.h"


@implementation AIDelegate


-(id) initWithCreature:(FDCreature *)c Layers:(ActionLayers *)l
{
	self = [super init];
	
	creature = c;
	layers = l;
	
	return self;
}

-(void) takeAction
{
	
}

-(void) setParameter:(id)param
{
	
}

-(void) initDistanceResolver
{
	BattleField *field = [[layers getFieldLayer] getField];	
	int fieldHeight = [field mapSize].height;
	int fieldWidth = [field mapSize].width;
	
	FDIntMap *map = [[FDIntMap alloc] initWidth:fieldWidth Height:fieldHeight];
	for (int i = 1; i <= fieldWidth; i++) {
		for (int j = 1; j <= fieldHeight; j++) {
			
			GroundBlock *block = [[field getGroundField] blockAtX:i Y:j];
			switch ([block getAccessType])
			{
				case GroundBlockTypeGround:
				case GroundBlockTypeForest:
					[map setX:i Y:j Value: PathBlockType_Plain];
					break;
				case GroundBlockTypeChasm:
					// If creature can fly
					if (FALSE) {
						[map setX:i Y:j Value: PathBlockType_Plain];
					}
					else {
						[map setX:i Y:j Value: PathBlockType_Blocked];
					}
					break;
				case GroundBlockTypeGap:
					[map setX:i Y:j Value: PathBlockType_Blocked];
					break;
				default:
					break;
			}
		}
	}
	disResolver = [[DistanceResolver alloc] initWithMap:map Width:fieldWidth Height:fieldHeight];
	
	[map release];
}

-(CGPoint) generatePos:(CGPoint)targetPos
{
	BattleField *field = [[layers getFieldLayer] getField];
	
	//[disResolver resolveDistanceFrom:targetPos terminateAt:CGPointMake(1, 1)];
	CGPoint originPos = [field getObjectPos:creature];
	[disResolver resolveDistanceFrom:targetPos terminateAt:originPos];
	
	// Find the scope
	float minDistance = 999;
	FDPosition *finalPos = [FDPosition positionX:originPos.x Y:originPos.y];
	NSMutableArray *scopeArray = [field searchMoveScope:creature];
	
	for (FDPosition *pos in scopeArray) {
		float distance = [disResolver getDistanceTo:[pos posValue]];
		if (distance < minDistance) {
			minDistance = distance;
			finalPos = pos;
		}
	}
	
	NSLog(@"Get Target Pos: %f, %f", [finalPos posValue].x, [finalPos posValue].y);
	
	return [finalPos posValue];
}

@end
