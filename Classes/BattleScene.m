//
//  BattleScene.m
//  FlameDragon
//
//  Created by sui toney on 12-10-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "BattleScene.h"
#import "DataDepot.h"
#import "FDWindow.h"
#import "FDSpriteStore.h"
#import "FDSlideAnimation.h"
#import "FDFightFrameDefinition.h"


@implementation BattleScene

-(id) initWithBackgroundImageId:(int)imageId
{
	self = [super init];
	
	layer = [CCLayer node];	
	[self addChild: layer];
	
	FDSprite *background = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Background-%02d.png", imageId]];
	[background addToLayer:layer];
	[background setLocation:[FDWindow screenCenter]];
	
	taiSprite = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Tai-%02d.png", imageId]];
	[taiSprite addToLayer:layer];
	[taiSprite setLocation:[FDWindow fightingTaiPosition]];
	[taiSprite retain];
	
	return self;
}

-(void) start
{
}


-(void) setPostMethod:(SEL)sel param1:(id)o1 param2:(id)o2 Obj:(id)obj
{
	postMethod = sel;
	obj1 = [o1 retain];
	obj2 = [o2 retain];
	object = obj;
}

-(CGPoint) getBarLocation:(FDCreature *)creature
{
	if ([creature getCreatureType] == CreatureType_Friend || [creature getCreatureType] == CreatureType_Npc) {
		return [FDWindow fightingFriendBarPosition];
	}
	else {
		return [FDWindow fightingEnemyBarPosition];
	}	
}

-(void) dealloc
{
	[taiSprite release];
	
	if (obj1 != nil) {
		[obj1 release];
	}
	if (obj2 != nil) {
		[obj2 release];
	}
	
	[super dealloc];
}

@end
