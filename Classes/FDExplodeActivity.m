//
//  FDExplodeActivity.m
//  FlameDragon
//
//  Created by sui toney on 11-12-4.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDExplodeActivity.h"
#import "DataDepot.h"
#import "FDSlideAnimation.h"

@implementation FDExplodeActivity

-(id) initWithObject:(FDCreature *)obj Field:(BattleField *)f
{
	self = [super init];
	
	creature = obj;
	field = f;
	
	return self;
}

-(void) initialize
{
	[creature setActionStatus:ActionStatus_Dead];
	
	AnimationDefinition *def = [[DataDepot depot] getAnimationDefinition:AnimationType_Die Id:[[creature getDefinition] getAnimationId]];
	animation = [[FDSlideAnimation alloc] initWithDefinition:def Sprite:[creature getSprite]];
}

-(void) mainTick:(int)synchronizeTick
{
	[animation takeTick:synchronizeTick];
	
	if ([animation hasFinished]) {
		hasFinished = TRUE;
		
		[[field getDeadCreatureList] addObject:creature];
		[field removeObject:creature]; 
	}
}



@end
