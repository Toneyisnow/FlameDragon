//
//  ArrivePositionCondition.h
//  FlameDragon
//
//  Created by sui toney on 12-11-18.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDEventCondition.h"
#import "FDCreature.h"


@interface ArrivePositionCondition : FDEventCondition {

	int creatureId;
	CGPoint eventPosition;
}

-(id) initWithCreatureId:(int)c Position:(CGPoint)pos;


@end
