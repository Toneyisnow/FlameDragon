//
//  EventChapter99.m
//  FlameDragon
//
//  Created by sui toney on 12-11-28.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventChapter99.h"


@implementation EventChapter99

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(round1)];

	[self loadDieEvent:1 Action:@selector(gameOver)];
	
	
	int ed1 = [self loadDieEvent:13 Action:@selector(oneDead)];
	
	int e1 = [self loadPositionEvent:11 AtPosition:CGPointMake( 1, 9) Action:@selector(onEscaped1)];
	
	[eventHandler setEvent:e1 dependentOn:ed1];
	
	NSLog(@"Chapter99 events loaded.");

}

-(void) round1
{
	// Creatures
	FDFriend *friend1 = [[FDFriend alloc] initWithDefinition:1 Id:1];
	
	NSLog(@"friend1 animation id %d", [[friend1 getDefinition] getAnimationId]);
	[field addFriend:friend1 Position:CGPointMake(8, 15)];
	[friend1 release];
	
	FDFriend *friend2 = [[FDFriend alloc] initWithDefinition:2 Id:2];
	[field addFriend:friend2 Position:CGPointMake(6, 16)];
	[friend2 release];
	
	FDFriend *friend3 = [[FDFriend alloc] initWithDefinition:3 Id:3];
	[field addFriend:friend3 Position:CGPointMake(9, 17)];
	[friend3 release];
	
	FDFriend *friend4 = [[FDFriend alloc] initWithDefinition:4 Id:4];
	[field addFriend:friend4 Position:CGPointMake(12, 18)];
	[friend4 release];
	
	FDFriend *friend5 = [[FDFriend alloc] initWithDefinition:8 Id:8];
	[field addFriend:friend5 Position:CGPointMake(10, 18)];
    [friend5.data addMagic:501];
	[friend5 release];
	
    for (int i=0; i<30; i++) {
        [friend2 levelUp];
        friend2.data.mpCurrent = friend2.data.mpMax;
    }
    
    [friend2.data.itemList addObject:[NSNumber numberWithInt:117]];
    [friend2.data.itemList addObject:[NSNumber numberWithInt:118]];
    [friend2.data.itemList addObject:[NSNumber numberWithInt:119]];
    [friend2.data.itemList addObject:[NSNumber numberWithInt:120]];
    [friend2.data.itemList addObject:[NSNumber numberWithInt:121]];
    
	/*
	FDFriend *friend16 = [[FDFriend alloc] initWithDefinition:1016 Id:6];
	[field addFriend:friend16 Position:CGPointMake(9, 18)];
	[friend16 release];
	*/
	/*
	FDNpc *npc = [[FDNpc alloc] initWithDefinition:50103 Id:41];
	[field addNpc:npc Position:CGPointMake(8, 20)];
	[npc release];
	 */
	
	// Enemy
	FDEnemy *enemy1 = [[FDEnemy alloc] initWithDefinition:50101 Id:11];
	//[field addEnemy: enemy1 Position:CGPointMake(1, 9)];
	enemy1.data.statusEnhanceAp = 2;
	enemy1.data.statusEnhanceDp = 1;
	enemy1.data.statusEnhanceDx = 2;
	enemy1.data.statusFrozen = 3;
	enemy1.data.statusProhibited = 1;
	enemy1.data.statusPoisoned = 2;
	
	
	[enemy1 release];
	
	FDEnemy *enemy2 = [[FDEnemy alloc] initWithDefinition:50505 Id:29];
	[field addEnemy: enemy2 Position:CGPointMake(4, 19)];
	[enemy2 release];
	
	FDEnemy *enemy3 = [[FDEnemy alloc] initWithDefinition:50101 Id:13 DropItem:102];
	[field addEnemy: enemy3 Position:CGPointMake(6, 18)];
	[enemy3 release];
	
	FDEnemy *enemy4 = [[FDEnemy alloc] initWithDefinition:50101 Id:14 DropItem:102];
	[field addEnemy: enemy4 Position:CGPointMake(7, 18)];
	[enemy4 release];
	
	FDEnemy *enemy5 = [[FDEnemy alloc] initWithDefinition:50101 Id:15 DropItem:102];
	[field addEnemy: enemy5 Position:CGPointMake(6, 17)];
	[enemy5 release];
	
	FDEnemy *enemy6 = [[FDEnemy alloc] initWithDefinition:51001 Id:16 DropItem:102];
	//[field addEnemy: enemy6 Position:CGPointMake(5, 18)];
	[enemy6 release];
	
	[self setAiOfId:13 withType:AIType_StandBy];
	
	
	FDTreasure *treasure1 = [FDTreasure treasureWithType:TreasureType_Red Item:101];
	[field addObject:treasure1 Position:CGPointMake(4, 2)];
}

-(void) oneDead
{
	[self showTalkMessage:4 conversation:3 sequence:1];
	
	/*
	[eventHandler deactivateEvent:ed1];
	[eventHandler deactivateEvent:ed2];
	[eventHandler deactivateEvent:ed3];
	[eventHandler deactivateEvent:ed4];
	*/
	
	[super setAiOfId:11 EscapeTo:CGPointMake( 1, 9)];
	
}

-(void) onEscaped1
{
	FDCreature *c = [field getCreatureById:11];
	if (c != nil) {
		[field removeObject:c];
	}
}

@end
