//
//  AIDefensiveDelegate.m
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "AIDefensiveDelegate.h"
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
#import "FDRandom.h"

@implementation AIDefensiveDelegate

-(id) initWithCreature:(FDCreature *)c Layers:(ActionLayers *)l
{
	self = [super initWithCreature:c Layers:l];
	operationTarget = nil;
	return self;
}

-(void) takeAction
{
	CCLOG(@"AIDefensiveDelegate take action on creature %d", [creature getIdentifier]);
	
	BattleField *field = [[layers getFieldLayer] getField];
    
	if ([self needAndCanRecover]) {
		
	} else
        
    if ([self canRecover]) {
        
		operationTarget = [self searchDefensiveTarget];
        
        if (operationTarget == nil) {
            CGPoint targetPos = [self generatePos:[field getObjectPos:operationTarget]];
            [field setCursorTo:targetPos];
            [layers moveCreature:creature To:targetPos showMenu:FALSE];
        
            [layers appendToCurrentActivityMethod:@selector(searchRescueTarget) Param1:nil Param2:nil Obj:self];
            
        } else if ([self needRecover]) {
            [self selfRecover];
            [layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];
            
        } else {
            [self makeMove];
        }
	} else {
        [self makeMove];
    }
}

-(BOOL) needRecover
{
    return (creature.data.hpCurrent < creature.data.hpMax);
}

-(FDCreature *) searchDefensiveTarget
{
    BattleField *field = [[layers getFieldLayer] getField];
	int fieldHeight = [field mapSize].height;
	int fieldWidth = [field mapSize].width;
	CGPoint currentPos = [field getObjectPos:creature];
	
	FDCreature *terminateCreature = nil;
	NSMutableArray *terminateCandidates = [[NSMutableArray alloc] init];
	if ([creature getCreatureType] == CreatureType_Enemy)
	{
		[terminateCandidates addObjectsFromArray:[field getEnemyList]];
	}
	else if ([creature getCreatureType] == CreatureType_Npc)
	{
		[terminateCandidates addObjectsFromArray:[field getFriendList]];
        [terminateCandidates addObjectsFromArray:[field getNpcList]];
	}
	
	int candidateIndex = 0;
	while (candidateIndex < [terminateCandidates count]-1) {
        
        FDCreature *c = [terminateCandidates objectAtIndex:candidateIndex];
        if (c != creature && c.data.hpCurrent < c.data.hpMax) break;
		candidateIndex ++;
	}
	terminateCreature = [terminateCandidates objectAtIndex:candidateIndex];
    
    FDIntMap *map = [super getGroundMap:creature];
    DistanceResolver *disResolver = [[DistanceResolver alloc] initWithMap:map Width:fieldWidth Height:fieldHeight];
	[disResolver resolveDistanceFrom:currentPos terminateAt:[field getObjectPos:terminateCreature]];
	
	float minDis = 999;
	FDCreature *finalTarget = terminateCreature;
	for (FDCreature *c in terminateCandidates) {
		
		float distance = [disResolver getDistanceTo:[field getObjectPos:c]];
		if (distance < minDis && c.data.hpCurrent < c.data.hpMax) {
			minDis = distance;
			finalTarget = c;
		}
	}
    
	[terminateCandidates release];
    CCLOG(@"Find target: %d", [finalTarget getIdentifier]);
	return finalTarget;
}

-(void) searchRescueTarget
{
	BattleField *field = [[layers getFieldLayer] getField];
	
    FDCreature *target = nil;
    NSMutableArray *targets = [field getNearByFriend:creature];
    for (FDCreature *c in targets) {
        if (c.data.hpCurrent < c.data.hpMax && (target == nil || c.data.hpCurrent < target.data.hpCurrent)) {
            target = c;
        }
    }
    
    int itemIndex = [self getRecoverItemIndex];
    if (target != nil && itemIndex >= 0) {
        [layers useItem:creature ItemIndex:itemIndex Target:target];
    } else {
        [layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];
    }
}

-(void) makeMove
{
    // Move to any of the creatures
    BattleField *field = [[layers getFieldLayer] getField];
	
    NSMutableArray *terminateCandidates = [[NSMutableArray alloc] init];
	if ([creature getCreatureType] == CreatureType_Enemy)
	{
		[terminateCandidates addObjectsFromArray:[field getEnemyList]];
	}
	else if ([creature getCreatureType] == CreatureType_Npc)
	{
		[terminateCandidates addObjectsFromArray:[field getFriendList]];
        [terminateCandidates addObjectsFromArray:[field getNpcList]];
	}
    
    FDRandom *ran = [FDRandom from:1 to:[terminateCandidates count]];
    FDCreature *target = [terminateCandidates objectAtIndex:ran];
    [terminateCandidates release];
    
    CGPoint targetPos = [self generatePos:[field getObjectPos:target]];
    [field setCursorTo:targetPos];
    [layers moveCreature:creature To:targetPos showMenu:FALSE];
    
    [layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];
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

-(void) setParameter:(id)param
{
	// No implement
}

-(void) dealloc
{
	//[disResolver release];
	[super dealloc];
}
@end
