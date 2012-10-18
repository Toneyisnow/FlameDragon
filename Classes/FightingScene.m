//
//  FightingScene.m
//  FlameDragon
//
//  Created by sui toney on 12-10-18.
//  Copyright 2012 ms. All rights reserved.
//

#import "FightingScene.h"
#import "DataDepot.h"
#import "FDWindow.h"
#import "FDSpriteStore.h"


@implementation FightingScene

-(id) initWithSubject:(FDCreature *)sub Target:(FDCreature *)tar Information:(FightingInformation *)info Background:(int)backgroundImageId
{
	self = [self init];
	
	if (subject == nil || target == nil || fightingInfo == nil) {
		NSError(@"FightingScene init error: parameter is nil");
		return self;
	}
	
	subject = [sub retain];
	target = [tar retain];
	fightingInfo = [info retain];
	
	subjectAttackAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightAttack Id:[[subject getDefinition] getAnimationId]];
	subjectIdleAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightIdle Id:[[subject getDefinition] getAnimationId]];
	
	targetAttackAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightAttack Id:[[target getDefinition] getAnimationId]];
	targetIdleAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightIdle Id:[[target getDefinition] getAnimationId]];
	
	
	layer = [CCLayer node];	
	
	FDSprite *background = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Background-%02d.png", backgroundImageId]];
	[background addToLayer:layer];
	[background setLocation:[FDWindow screenCenter]];
	
	FDSprite *tai = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Tai-%02d.png", backgroundImageId]];
	[tai addToLayer:layer];
	[tai setLocation:[FDWindow fightingTaiPosition]];
	
	[self addChild: layer];
	
	
	return self;
}

-(void) start
{
	tickCount = 0;
	[self schedule: @selector(step:)];

	// Subject
	subjectSprite = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Fight-%03d-1-01.png", [[subject getDefinition] getAnimationId]]];
	[subjectSprite addToLayer:layer];
	[subjectSprite setLocation:[FDWindow screenCenter]];
	[subjectSprite retain];
	
	// Target
	targetSprite = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Fight-%03d-1-01.png", [[[targets objectAtIndex:0] getDefinition] getAnimationId]]];
	[targetSprite addToLayer:layer];
	[targetSprite setLocation:CGPointMake(screenSize.width /2, screenSize.height /2)];
	[targetSprite retain];
	
	// Creature Bar
	subjectBar = [[CreatureInfoBar alloc] initWithCreature:subject ClickedOn:CGPointMake(0, 0)]; 
	if ([fightingInfo getBackInfo1] == nil) {
		[subjectBar setHp:subject.data.hpCurrent Mp:subject.data.mpCurrent];
	} else {
		[subjectBar setHp:[[fightingInfo getBackInfo1] getBefore] Mp:subject.data.mpCurrent];
	}

	// Target Bar
	targetBar = [[CreatureInfoBar alloc] initWithCreature:target ClickedOn:CGPointMake(0, 0)]; 
	[targetBar setHp:[[fightingInfo getAttackInfo1] getBefore] Mp:target.data.mpCurrent];
	
	if ([subject getCreatureType] == CreatureType_Friend || [subject getCreatureType] == CreatureType_Npc) {
		[subjectBar setLocation:[FDWindow fightingFriendBarPosition]];
		[targetBar setLocation:[FDWindow fightingEnemyBarPosition]];
	}
	else {
		[subjectBar setLocation:[FDWindow fightingEnemyBarPosition]];
		[targetBar setLocation:[FDWindow fightingFriendBarPosition]];
	}
	[subjectBar show:layer];
	[targetBar show:layer];
	
	
	subjectAnimation = [[FDCombinedAnimation alloc] init];
	targetAnimation = [[FDCombinedAnimation alloc] init];
	
	[self appendIdleAnimation];
	
	if ([fightingInfo getAttackInfo1] != nil) {
		[self appendSubjectAttackAnimation:1];
	}
	if ([fightingInfo getAttackInfo2] != nil) {
		[self appendSubjectAttackAnimation:2];
	}
	if ([fightingInfo getBackInfo1] != nil) {
		[self appendTargetAttackAnimation:1];
	}
	if ([fightingInfo getBackInfo2] != nil) {
		[self appendTargetAttackAnimation:2];
	}
	
	[self appendIdleAnimation];
	[self appendIdleAnimation];
}

-(void) appendIdleAnimation
{
	FDSlideAnimation *ani = [[FDSlideAnimation alloc] initWithDefinition:subjectIdleAni Sprite:subject];
	[subjectAnimation addAnimation:ani];
	[ani release];
	
	ani = [[FDSlideAnimation alloc] initWithDefinition:targetIdleAni Sprite:target];
	[targetAnimation addAnimation:ani];
	[ani release];
}

-(void) appendSubjectAttackAnimation:(int)tagIndex
{
	FDSlideAnimation *ani = [[FDSlideAnimation alloc] initWithDefinition:subjectAttackAni Sprite:subject];
	[ani onRenderFrame:@selector(onSubjectAttack:Tag:) Id:self];
	[ani setTagIndex:tagIndex];
	[subjectAnimation addAnimation:ani];
	[ani release];
	
	while ([targetAnimation totalFrame] < [subjectAnimation totalFrame]) {
		ani = [[FDSlideAnimation alloc] initWithDefinition:targetIdleAni Sprite:target];
		[targetAnimation addAnimation:ani];
		[ani release];
	}
}

-(void) appendTargetAttackAnimation:(int)tagIndex
{
	FDSlideAnimation *ani = [[FDSlideAnimation alloc] initWithDefinition:targetAttackAni Sprite:target];
	[ani onRenderFrame:@selector(onTargetAttack:Tag:) Id:self];
	[ani setTagIndex:tagIndex];
	[targetAnimation addAnimation:ani];
	[ani release];
	
	while ([subjectAnimation totalFrame] < [targetAnimation totalFrame]) {
		ani = [[FDSlideAnimation alloc] initWithDefinition:subjectIdleAni Sprite:subject];
		[subjectAnimation addAnimation:ani];
		[ani release];
	}
}

-(void) setPostMethod:(SEL)sel param1:(id)o1 param2:(id)o2 Obj:(id)obj
{
	postMethod = sel;
	obj1 = [o1 retain];
	obj2 = [o2 retain];
	object = obj;
}

-(void) step: (ccTime) delta
{
	// NSLog(@"Scene tick");
	tickCount ++;
	
	[subjectAnimation takeTick:tickCount];
	[targetAnimation takeTick:tickCount];
	
	if ([subjectAnimation hasFinished] && [targetAnimation hasFinished]) {
		
		[[CCDirector sharedDirector] popScene];
		
		// Perform post method
		[object performSelector:postMethod withObject:obj1 withObject:obj2];
	}
}

-(void) onSubjectAttack:(FDFrameDefinition *)frame Tag:(int)tagIndex
{
	FDFightFrameDefinition *fightFrame = (FDFightFrameDefinition *)frame;
	AttackInformation *attackInfo = (tagIndex == 1) ? [fightingInfo getAttackInfo1] : [fightingInfo getAttackInfo2];
	
	if ([fightFrame isHitting]) {
		
		int nowValue = [attackInfo getBefore] - ([attackInfo getBefore] - [attackInfo getAfter]) * [fightFrame getHittingRate];
		if (nowValue < 0)
			nowValue = 0;
		
		[targetBar setHp:nowValue Mp:-1];
		
		if ([attackInfo isCritical]) {
			// TODO: Adding critical frame
		}
	}
}

-(void) onTargetAttack:(FDFrameDefinition *)frame Tag:(int)tagIndex
{
	FDFightFrameDefinition *fightFrame = (FDFightFrameDefinition *)frame;
	AttackInformation *attackInfo = (tagIndex == 1) ? [fightingInfo getBackInfo1] : [fightingInfo getBackInfo2];
	
	if ([fightFrame isHitting]) {
		
		int nowValue = [attackInfo getBefore] - ([attackInfo getBefore] - [attackInfo getAfter]) * [fightFrame getHittingRate];
		if (nowValue < 0)
			nowValue = 0;
		
		[subjectBar setHp:nowValue Mp:-1];
		
		if ([attackInfo isCritical]) {
			// TODO: Adding critical frame
		}
	}	
}

-(void) dealloc
{
	[subject release];
	[target release];
	[fightingInfo release];
	
	if (obj1 != nil) {
		[obj1 release];
	}
	if (obj2 != nil) {
		[obj2 release];
	}
	
	[super dealloc];
}

@end
