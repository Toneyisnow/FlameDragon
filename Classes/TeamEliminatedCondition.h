//
//  TeamEliminatedCondition.h
//  FlameDragon
//
//  Created by sui toney on 12-1-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDEventCondition.h"
#import "FDCreature.h"

@interface TeamEliminatedCondition : FDEventCondition {
	
	CreatureType teamType;
	
	int previousCount;
}

-(id) initWithTeam:(CreatureType)t;

@end
