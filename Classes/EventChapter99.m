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
	
	FDFriend *friend5 = [[FDFriend alloc] initWithDefinition:5 Id:5];
	[field addFriend:friend5 Position:CGPointMake(10, 18)];
	[friend5 release];
	
	/*
	FDFriend *friend16 = [[FDFriend alloc] initWithDefinition:1016 Id:6];
	[field addFriend:friend16 Position:CGPointMake(9, 18)];
	[friend16 release];
	 */
	
	
	FDNpc *npc = [[FDNpc alloc] initWithDefinition:50103 Id:41];
	[field addNpc:npc Position:CGPointMake(8, 20)];
	[npc release];
	
	// Enemy
	FDEnemy *enemy1 = [[FDEnemy alloc] initWithDefinition:50101 Id:11];
	[field addEnemy: enemy1 Position:CGPointMake(5, 19)];
	[enemy1 release];
	
	FDEnemy *enemy2 = [[FDEnemy alloc] initWithDefinition:50102 Id:29];
	[field addEnemy: enemy2 Position:CGPointMake(4, 19)];
	[enemy2 release];
	
	FDEnemy *enemy3 = [[FDEnemy alloc] initWithDefinition:50101 Id:13];
	[field addEnemy: enemy3 Position:CGPointMake(6, 18)];
	[enemy3 release];
	
	FDEnemy *enemy4 = [[FDEnemy alloc] initWithDefinition:50403 Id:14];
	[field addEnemy: enemy4 Position:CGPointMake(7, 18)];
	[enemy4 release];
	
	FDEnemy *enemy5 = [[FDEnemy alloc] initWithDefinition:50404 Id:15];
	[field addEnemy: enemy5 Position:CGPointMake(6, 17)];
	[enemy5 release];
	
	FDEnemy *enemy6 = [[FDEnemy alloc] initWithDefinition:50405 Id:16];
	[field addEnemy: enemy6 Position:CGPointMake(5, 18)];
	[enemy6 release];
	
	
	FDTreasure *treasure1 = [FDTreasure treasureWithType:TreasureType_Red Item:101];
	[field addObject:treasure1 Position:CGPointMake(4, 2)];
}

@end
