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


-(void) searchAttackTarget
{
	BattleField *field = [[layers getFieldLayer] getField];
	FDCreature *target = [self findTarget];
	CGPoint targetpos = [field getObjectPos:target];
	BOOL inAttackScope = FALSE;
	
	if ([creature isAbleToAttack:target]) {
		NSMutableArray *scopeList = [field searchActionScope:[field getObjectPos:creature] Range:[creature attackRange]];
		for (FDPosition *pos in scopeList) {
			if ([FDPosition isEqual:[pos posValue] With:targetpos]) {
				inAttackScope = TRUE;
				break;
			}
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
