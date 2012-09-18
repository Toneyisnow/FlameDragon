//
//  CreatureDeadCondition.h
//  FlameDragon
//
//  Created by sui toney on 12-1-13.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDEventCondition.h"

@interface CreatureDeadCondition : FDEventCondition {

	int creatureId;
	bool creatureFound;
}

-(id) initWithCreatureId:(int)c;

@end
