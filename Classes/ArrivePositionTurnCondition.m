//
//  ArrivePositionTurnCondition.m
//  FlameDragon
//
//  Created by sui toney on 13-11-24.
//
//

#import "ArrivePositionTurnCondition.h"


@implementation ArrivePositionTurnCondition

-(id) initWithCreatureId:(int)c Position:(CGPoint)pos
{
	self = [super initWithCreatureId:c Position:pos];
	
	return self;
}

-(BOOL) isMatch:(ActionLayers *)layers
{
	return [layers isEndOfTurn] && [super isMatch:layers];
}


@end