//
//  FightTargetInfo.m
//  FlameDragon
//
//  Created by sui toney on 11-11-24.
//  Copyright 2011 ms. All rights reserved.
//

#import "FightTargetInfo.h"


@implementation FightTargetInfo

@synthesize creatureAniId, maxHp, previousHp, reducedHp;

-(id) initWithAniId:(int)aId Max:(int)m Previous:(int)p Reduce:(int)r
{
	self = [super init];
	
	creatureAniId = aId;
	maxHp = m;
	previousHp = p;
	reducedHp = r;
	
	return self;
}


@end
