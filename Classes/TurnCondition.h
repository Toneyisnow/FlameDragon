//
//  TurnCondition.h
//  FlameDragon
//
//  Created by sui toney on 11-12-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDEventCondition.h"
#import "ActionLayers.h"

@interface TurnCondition : FDEventCondition {

	TurnType turnType;
	int turnNumber;
}

-(id) initWithTurnType:(TurnType)type Number:(int)n;


@end
