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
#import "UsableItemDefinition.h"
#import "DataDepot.h"

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
	CGPoint targetPos = [self generatePos:[field getObjectPos:[self findTarget]]];
	
	if ([self needAndCanRecover]) {
		
		[self selfRecover];
		[layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];
	} else {
		
		[field setCursorTo:targetPos];
		[layers moveCreature:creature To:targetPos showMenu:FALSE];
	
		[layers appendToCurrentActivityMethod:@selector(searchAttackTarget) Param1:nil Param2:nil Obj:self];
	}
}

-(BOOL) needAndCanRecover
{
	BOOL needRecover = FALSE;
	if (creature.data.hpCurrent < creature.data.hpMax / 2) {
		needRecover = TRUE;
	}
	
	BOOL canRecover = FALSE;
	for (int index = 0; index < [creature.data.itemList count]; index++) {
		int itemId = [creature getItemId:index];
		if (itemId == 101 || itemId == 102 || itemId == 103) {
			canRecover = TRUE;
			break;
		}
	}
	
	return needRecover && canRecover;
}

-(void) selfRecover
{
	int itemIndex = -1;
	for (int index = 0; index < [creature.data.itemList count]; index++) {
		int itemId = [creature getItemId:index];
		if (itemId == 101 || itemId == 102 || itemId == 103) {
			itemIndex = index;
			break;
		}
	}
	
	if (itemIndex < 0) {
		return;
	}
	
	int itemId = [creature getItemId:itemIndex];
	UsableItemDefinition * itemDef = (UsableItemDefinition *)[[DataDepot depot] getItemDefinition:itemId];
	[itemDef usedBy:creature];
	
	[creature.data removeItem:itemIndex];
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

-(void) setParameter:(id)param
{
	// No implement
}

-(void) dealloc 
{
	[disResolver release];
	[super dealloc];
 }
@end
