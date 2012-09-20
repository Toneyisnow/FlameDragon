//
//  EventChapter2.h
//  FlameDragon
//
//  Created by sui toney on 12-4-1.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventHandler.h"
#import "ActionLayers.h"
#import "EventLoader.h"

@interface EventChapter2 : EventLoader {

	BOOL isAllNpcSaved;
}

-(void) round1;
-(void) round1_2;
-(void) round1_3;
-(void) round3;

-(void) setAiOfId:(int)creatureId EscapeTo:(CGPoint)pos;

@end
