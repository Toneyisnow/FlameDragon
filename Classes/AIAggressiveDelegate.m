//
//  AIAggressiveDelegate.m
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "AIAggressiveDelegate.h"
#import "FDOperationActivity.h"
#import "FDPointMap.h"
#import "FDPath.h"
#import "FDIntMap.h"
#import "GroundBlock.h"
#import "PathResolver.h"
#import "ScopeResolver.h"
#import "DistanceResolver.h"


@implementation AIAggressiveDelegate

-(id) initWithCreature:(FDCreature *)c Layers:(ActionLayers *)l
{
	self = [super initWithCreature:c Layers:l];
	
	[self initDistanceResolver];
	
	return self;
}

-(void) takeAction
{
	NSLog(@"AIAggressiveDelegate take action on creature %d", [creature getIdentifier]);
	
	BattleField *field = [[layers getFieldLayer] getField];
	CGPoint targetPos = [self generatePos];
	[field setCursorTo:targetPos];
	[layers moveCreature:creature To:targetPos showMenu:FALSE];
	
	[layers appendToCurrentActivityMethod:@selector(searchAttackTarget) Param1:nil Param2:nil Obj:self];
}

-(void) searchAttackTarget
{
	BattleField *field = [[layers getFieldLayer] getField];
	FDCreature *target = [self findTarget];
	CGPoint targetpos = [field getObjectPos:target];
	BOOL inAttackScope = FALSE;
	
	NSMutableArray *scopeList = [field searchActionScope:[field getObjectPos:creature] Range:[creature attackRange]];
	for (FDPosition *pos in scopeList) {
		if ([FDPosition isEqual:[pos posValue] With:targetpos]) {
			inAttackScope = TRUE;
			break;
		}
	}
	
	//[field setCursorTo:targetpos];
	if (inAttackScope) {
		[layers appendToCurrentActivityMethod:@selector(attackFrom:Target:) Param1:creature Param2:target];
	}
	else {
		[layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];
	}
}

-(CGPoint) generatePos
{
	BattleField *field = [[layers getFieldLayer] getField];
	CGPoint targetPos = [field getObjectPos:[self findTarget]];
	
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

-(BOOL) foundInArray:(NSMutableArray *)scopeArray Pos:(CGPoint)targetpos
{
	for (FDPosition *pos in scopeArray) {
		if ([FDPosition isEqual:[pos posValue] With:targetpos]) {
			return TRUE;
		}
	}
	return FALSE;
}

-(FDCreature *) findTarget
{
	BattleField *field = [[layers getFieldLayer] getField];	
	CGPoint currentPos = [field getObjectPos:creature];
	
	FDCreature *terminateCreature = nil;
	if ([creature isKindOfClass:[FDEnemy class]])
	{
		terminateCreature = [[field getFriendList] objectAtIndex:0];
	}
	else if ([creature isKindOfClass:[FDNpc class]])
	{
		terminateCreature = [[field getEnemyList] objectAtIndex:0];
	}
	
	[disResolver resolveDistanceFrom:currentPos terminateAt:[field getObjectPos:terminateCreature]];

	float minDistance = 999;
	FDCreature *finalTarget = nil;
	
	NSMutableArray *candidateList = [[NSMutableArray alloc] init];
	if ([creature isKindOfClass:[FDEnemy class]]) {
		[candidateList addObjectsFromArray:[field getFriendList]];
		[candidateList addObjectsFromArray:[field getNpcList]];
	}
	else if ([creature isKindOfClass:[FDNpc class]]) {
		[candidateList addObjectsFromArray:[field getEnemyList]];
	}
	
	for (FDCreature *c in candidateList) {
		
		float distance = [disResolver getDistanceTo:[field getObjectPos:c]];
		if (distance < minDistance) {
			minDistance = distance;
			finalTarget = c;
		}
	}
	
	NSLog(@"Find target: %d", [finalTarget getIdentifier]);
	
	return finalTarget;
}

-(void) dealloc 
{
	[disResolver release];
	[super dealloc];
 }
@end
