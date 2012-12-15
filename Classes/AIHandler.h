//
//  AIHandler.h
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "IListener.h"
#import "ActionLayers.h"

@interface AIHandler : IListener {

	
	ActionLayers *layers;
	Class creatureClass;
	
	int lastOperatedCreatureId;
	
}

-(id) initEnemyHandlerWithLayers:(ActionLayers *)l;
-(id) initNpcHandlerWithLayers:(ActionLayers *)l;

-(void) runAiDelegate:(FDCreature *)creature;

@end
