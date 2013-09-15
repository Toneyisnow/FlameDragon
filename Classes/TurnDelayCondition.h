//
//  TurnDelayCondition.h
//  FlameDragon
//
//  Created by sui toney on 13-9-11.
//
//

#import "cocos2d.h"
#import "FDEventCondition.h"
#import "ActionLayers.h"

@interface TurnDelayCondition : FDEventCondition {
    
	TurnType turnType;
	int turnNumber;
}

-(id) initWithTurnType:(TurnType)type DelayCount:(int)n;

@end
