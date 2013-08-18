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
#import "DataDepot.h"
#import "UsableItemDefinition.h"

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

-(FDIntMap *) getGroundMap:(FDCreature *)c
{
    BattleField *field = [[layers getFieldLayer] getField];
	
    if ([c canFly])
    {
        return [[field getGroundField] getGroundScopeMapForFly];
    }
    else if ([c isKnight])
    {
        return [[field getGroundField] getGroundScopeMapForKnight];
    }
    else if ([c isKnight])
    {
        return [[field getGroundField] getGroundScopeMapForMarshMonster];
    }
    
    return [[field getGroundField] getGroundScopeMapForGround];
}

-(CGPoint) generatePos:(CGPoint)targetPos // forAttack:(BOOL)attackOnly
{
	CCLOG(@"generatePos: target Pos: %f, %f", targetPos.x, targetPos.y);
	
	BattleField *field = [[layers getFieldLayer] getField];
	int fieldHeight = [field mapSize].height;
	int fieldWidth = [field mapSize].width;
	
	CGPoint originPos = [field getObjectPos:creature];
	
    FDIntMap *map = [self getGroundMap:creature];
    DistanceResolver *disResolver = [[DistanceResolver alloc] initWithMap:map Width:fieldWidth Height:fieldHeight];

    [disResolver resolveDistanceFrom:targetPos terminateAt:originPos];
	
	// Find the scope
	float bestDistance = 999;
	int bestDistanceInUnit = -1;
	BOOL inAttackScope = FALSE;
	
	FDPosition *finalPos = [FDPosition positionX:originPos.x Y:originPos.y];
	NSMutableArray *scopeArray = [field searchMoveScope:creature];
	
	FDRange *range = nil;
	if ([field getCreatureByPos:targetPos] != nil) {
		range = [creature attackRange];
	} else {
		range = [FDRange rangeWithMin:0 Max:0];
	}
	
	for (FDPosition *pos in scopeArray) {
		
		int distanceInUnit = [field getDirectDistancePos:targetPos And:[pos posValue]];
		if ([range containsValue:distanceInUnit]) {
			
			inAttackScope = TRUE;
			if (distanceInUnit > bestDistanceInUnit) {
				bestDistanceInUnit = distanceInUnit;
				finalPos = pos;
			}
		}
		
		if (!inAttackScope) {
			float distance = [disResolver getDistanceTo:[pos posValue]];
		
			if (distance < bestDistance) {
				bestDistance = distance;
				finalPos = pos;
			}
		}
	}
	
	CCLOG(@"Get Target Pos: %f, %f", [finalPos posValue].x, [finalPos posValue].y);
    [disResolver release];
    
	return [finalPos posValue];
}

-(FDCreature *) findTarget
{
	BattleField *field = [[layers getFieldLayer] getField];	
	int fieldHeight = [field mapSize].height;
	int fieldWidth = [field mapSize].width;
	CGPoint currentPos = [field getObjectPos:creature];
	
	FDCreature *terminateCreature = nil;
	NSMutableArray *terminateCandidates = [[NSMutableArray alloc] init];
	if ([creature getCreatureType] == CreatureType_Enemy)
	{
		[terminateCandidates addObjectsFromArray:[field getFriendList]];
        [terminateCandidates addObjectsFromArray:[field getNpcList]];
	}
	else if ([creature getCreatureType] == CreatureType_Npc)
	{
		[terminateCandidates addObjectsFromArray:[field getEnemyList]];
	}
	
	int candidateIndex = 0;
	while (candidateIndex < [terminateCandidates count]-1 && ![creature isAbleToAttack:[terminateCandidates objectAtIndex:candidateIndex]]) {
		candidateIndex ++;
	}
	terminateCreature = [terminateCandidates objectAtIndex:candidateIndex];
	 
    FDIntMap *map = [self getGroundMap:creature];
    DistanceResolver *disResolver = [[DistanceResolver alloc] initWithMap:map Width:fieldWidth Height:fieldHeight];
	[disResolver resolveDistanceFrom:currentPos terminateAt:[field getObjectPos:terminateCreature]];
	
	float minDistance = 999;
	FDCreature *finalTarget = terminateCreature;
	
	for (FDCreature *c in terminateCandidates) {
		
		float distance = [disResolver getDistanceTo:[field getObjectPos:c]];
		if (distance < minDistance && [creature isAbleToAttack:c]) {
			minDistance = distance;
			finalTarget = c;
		}
	}
	[terminateCandidates release];
    
	CCLOG(@"Find target: %d", [finalTarget getIdentifier]);
	
	return finalTarget;
}

-(BOOL) needRecover
{
    if ([creature getCreatureType] == CreatureType_Npc && creature.data.hpCurrent < creature.data.hpMax) {
		return TRUE;
	}
	if (creature.data.hpCurrent < creature.data.hpMax / 2) {
		return TRUE;
	}
	return FALSE;
}

-(BOOL) needAndCanRecover
{
	return [self needRecover] && [self canRecover];
}

-(BOOL) canRecover
{
    return [self getRecoverItemIndex] >= 0;
}

-(int) getRecoverItemIndex
{
    for (int index = 0; index < [creature.data.itemList count]; index++) {
		int itemId = [creature getItemId:index];
		if (itemId == 101 || itemId == 102 || itemId == 103 || itemId == 104 || itemId == 122) {
			return index;
		}
	}
    return -1;
}

-(void) selfRecover
{
	int itemIndex = [self getRecoverItemIndex];
	
	if (itemIndex < 0) {
		return;
	}
	
	int itemId = [creature getItemId:itemIndex];
	UsableItemDefinition * itemDef = (UsableItemDefinition *)[[DataDepot depot] getItemDefinition:itemId];
	[itemDef usedBy:creature];
	
	[creature.data removeItem:itemIndex];
}

-(void) dealloc
{
    /*if (disResolver != nil) {
        [disResolver release];
    }
    */
    
    [super dealloc];
}

@end
