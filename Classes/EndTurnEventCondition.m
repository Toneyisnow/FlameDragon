//
//  EndTurnEventCondition.m
//  FlameDragon
//
//  Created by sui toney on 13-11-24.
//
//

#import "EndTurnEventCondition.h"

@implementation EndTurnEventCondition

-(BOOL) isMatch:(ActionLayers *)layers
{
	return [layers isEndOfTurn];
}

@end
