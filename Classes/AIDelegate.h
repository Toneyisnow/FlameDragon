//
//  AIDelegate.h
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDCreature.h"
#import "ActionLayers.h"

@interface AIDelegate : NSObject {

	FDCreature *creature;
	ActionLayers *layers;
}

-(id) initWithCreature:(FDCreature *)c Layers:(ActionLayers *)layers;

-(void) takeAction;

@end
