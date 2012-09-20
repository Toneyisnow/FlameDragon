//
//  EventLoader.h
//  FlameDragon
//
//  Created by sui toney on 12-3-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventHandler.h"
#import "ActionLayers.h"

@interface EventLoader : NSObject {

	EventHandler *eventHandler;
	ActionLayers *layers;
	
	
}

-(void) loadWithLayers:(ActionLayers *)l;

-(void) loadEvents;
-(void) settleFriend:(int)creatureId At:(CGPoint)loc;

-(void) loadTurnEvent:(TurnType) turnType Turn:(int)turnNum Action:(SEL)action;
-(void) loadDieEvent:(int)creatureId Action:(SEL)action;
-(void) loadDyingEvent:(int)creatureId Action:(SEL)action;
-(void) loadTeamEvent:(CreatureType) creatureType Action:(SEL)action;

-(void) showTalkMessage:(int)charId conversation:(int)converId sequence:(int)sequenceId;

-(void) gameOver;

@end
