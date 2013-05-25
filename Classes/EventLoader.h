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
	
	BattleField *field;
	
	int generatedEventId;
}

-(void) loadWithLayers:(ActionLayers *)l;

-(void) loadEvents;
-(int) loadSingleEvent:(FDEventCondition *)condition Action:(SEL)action;

-(void) settleFriend:(int)friendIndex At:(CGPoint)loc;

-(int) loadTurnEvent:(TurnType) turnType Turn:(int)turnNum Action:(SEL)action;
-(int) loadDieEvent:(int)creatureId Action:(SEL)action;
-(int) loadDyingEvent:(int)creatureId Action:(SEL)action;
-(int) loadTeamEvent:(CreatureType) creatureType Action:(SEL)action;
-(int) loadPositionEvent:(int)creatureId AtPosition:(CGPoint)pos Action:(SEL)action;

-(void) showTalkMessage:(int)charId conversation:(int)converId sequence:(int)sequenceId;

-(void) setAiOfId:(int)creatureId EscapeTo:(CGPoint)pos;
-(void) setAiOfId:(int)creatureId withType:(AIType) type;

-(BOOL) teamHasItem:(int)itemId;
-(void) teamConsumeItem:(int)itemId;

-(void) addItemToTeam:(int)itemId;

-(void) gameOver;

@end
