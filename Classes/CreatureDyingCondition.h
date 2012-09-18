//
//  CreatureDyingCondition.h
//  FlameDragon
//
//  Created by sui toney on 12-1-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDEventCondition.h"

@interface CreatureDyingCondition : FDEventCondition {
	
	int creatureId;
}

-(id) initWithCreatureId:(int)c;

@end
