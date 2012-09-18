//
//  FDBattleObject.m
//  FlameDragon
//
//  Created by sui toney on 11-11-5.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDBattleObject.h"


@implementation FDBattleObject

-(id) init 
{
	self = [super init];
	
	isDeprecated = FALSE;
	
	return self;
}

-(void) takeTick:(int)synchronizedTick
{
}

-(void) setLocation:(CGPoint)loc
{
	[sprite setLocation:loc];
}

-(int) zOrder
{
	return zOrder;
}

-(void) changeZOrder:(BattleObjectOrder)zorder
{
	[sprite updateZOrder:(int)zorder];
}


-(CGPoint) getLocation
{
	return [sprite location];
}

@end
