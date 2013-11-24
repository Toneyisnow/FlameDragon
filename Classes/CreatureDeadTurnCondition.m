//
//  CreatureDeadTurnCondition.m
//  FlameDragon
//
//  Created by sui toney on 13-11-24.
//
//
#import "CreatureDeadTurnCondition.h"


@implementation CreatureDeadTurnCondition


-(id) initWithCreatureId:(int)c
{
	self = [super initWithCreatureId:c];
	return self;
}

-(BOOL) isMatch:(ActionLayers *)layers
{
    return [layers isEndOfTurn] && [super isMatch:layers];
}


@end