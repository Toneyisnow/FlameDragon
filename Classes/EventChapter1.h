//
//  EventChapter1.h
//  FlameDragon
//
//  Created by sui toney on 11-12-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "EventHandler.h"
#import "ActionLayers.h"
#import "EventLoader.h"

@interface EventChapter1 : EventLoader {

//	EventHandler *eventHandler;
//	ActionLayers *layers;
}

//-(id) initWithLayers:(ActionLayers *)l;

//-(void) loadEvents;


-(void) round1_1;
-(void) round1_2_1;
-(void) round1_2_2;
-(void) round1_3;
-(void) round3;
-(void) round4;
-(void) round5_Boss;
-(void) round6_Npc;

// -(void) gameOver;
// -(void) finishChapter;


-(void) hanuoDie;
-(void) hawateDie;
-(void) enemyClear;
-(void) showBossDyingMessage;

@end
