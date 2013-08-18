//
//  AIHandler.m
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "AIHandler.h"
#import "AIAggressiveDelegate.h"
#import "AIMagicalAggressiveDelegate.h"
#import "AIDefensiveDelegate.h"
#import "AIMagicalDefensiveDelegate.h"
#import "AIGuardDelegate.h"
#import "AIMagicalGuardDelegate.h"
#import "AIEscapeDelegate.h"
#import "AIStandByDelegate.h"
#import "AITreasureDelegate.h"
#import "AITreasureParam.h"
#import "FDEnemy.h"
#import "FDFriend.h"
#import "FDNpc.h"


@implementation AIHandler

-(id) initEnemyHandlerWithLayers:(ActionLayers *)l
{
	self = [super init];
	
	creatureClass = [FDEnemy class];
	lastOperatedCreatureId = 0;
	
	layers = l;
	
	[layers setEnemyAiHandler:self];
	
	return self;
}

-(id) initNpcHandlerWithLayers:(ActionLayers *)l
{
	self = [super init];
	
	creatureClass = [FDNpc class];
	layers = l;
	
	[layers setNpcAiHandler:self];
	
	return self;
}

-(void) isNotified
{
	CCLOG(@"Enemy AI Handler is notified.");
	
	// find a creature and take action on it
	FDCreature *selectedCreature = nil;
	
	NSMutableArray *array = (creatureClass == [FDEnemy class]) ? [[[layers getFieldLayer] getField] getEnemyList]: [[[layers getFieldLayer] getField] getNpcList];
	for (FDCreature *creature in array) {
		
		if (creature.hasActioned || creature.data.statusFrozen > 0 || creature.pendingAction) {
			continue;
		}
		
		if (selectedCreature == nil || [creature getIdentifier] < [selectedCreature getIdentifier]) {
			selectedCreature = creature;
		}
	}
	
	if (selectedCreature == nil) {
		for (FDCreature *creature in array) {
			
			if (creature.hasActioned || ![creature isNotFrozen] || !creature.pendingAction) {
				continue;
			}
			
			if (selectedCreature == nil || [creature getIdentifier] < [selectedCreature getIdentifier]) {
				selectedCreature = creature;
			}
		}		
	}
	
	if (selectedCreature == nil) {
		
		CCLOG(@"Didn't find creature to operate.");
		return;
	}
	
	CCLOG(@"Select creature to operate.");
	[self runAiDelegate:selectedCreature];
}

-(void) runAiDelegate:(FDCreature *)creature
{
	AIDelegate *delegate = nil;
	
	switch (creature.data.aiType) {
		case AIType_Aggressive:
			if ([[creature getDefinition] isMagicalCreature]) {
				delegate = [[AIMagicalAggressiveDelegate alloc] initWithCreature:creature Layers:layers];
			} else {
				delegate = [[AIAggressiveDelegate alloc] initWithCreature:creature Layers:layers];
			}
			break;
		case AIType_Defensive:
			if ([[creature getDefinition] isMagicalCreature]) {
				delegate = [[AIMagicalDefensiveDelegate alloc] initWithCreature:creature Layers:layers];
			} else {
				delegate = [[AIAggressiveDelegate alloc] initWithCreature:creature Layers:layers];
			}
			break;
		case AIType_Guard:
			if ([[creature getDefinition] isMagicalCreature]) {
				delegate = [[AIMagicalGuardDelegate alloc] initWithCreature:creature Layers:layers];
			} else {
				delegate = [[AIGuardDelegate alloc] initWithCreature:creature Layers:layers];
			}
			break;
		case AIType_Escape:
			delegate = [[AIEscapeDelegate alloc] initWithCreature:creature Layers:layers];
			[delegate setParameter:creature.data.aiParam];
			break;
		case AIType_StandBy:
			delegate = [[AIStandByDelegate alloc] initWithCreature:creature Layers:layers];
			break;
		case AIType_Treasure:
			delegate = [[AITreasureDelegate alloc] initWithCreature:creature Layers:layers];
            [delegate setParameter:creature.data.aiParam];
			break;
		default:
			break;
	}
	
	if (delegate != nil)
	{
		lastOperatedCreatureId = [creature getIdentifier];
		[delegate takeAction];
		//[delegate release];
	}
}

@end
