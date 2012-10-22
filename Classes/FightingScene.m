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
#import "FDSlideAnimation.h"
#import "FDFightFrameDefinition.h"


@implementation FightingScene

-(id) initWithSubject:(FDCreature *)sub Target:(FDCreature *)tar Information:(FightingInformation *)info Background:(int)backgroundImageId
{
	self = [super initWithBackgroundImageId:backgroundImageId];
	
	if (sub == nil || tar == nil || info == nil) {
		NSLog(@"FightingScene init error: parameter is nil");
		return self;
	}
	
	subject = [sub retain];
	target = [tar retain];
	fightingInfo = [info retain];
	
	subjectAttackAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightAttack Id:[[subject getDefinition] getAnimationId]];
	subjectIdleAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightIdle Id:[[subject getDefinition] getAnimationId]];
	[subjectAttackAni retain];
	[subjectIdleAni retain];
	
	targetAttackAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightAttack Id:[[target getDefinition] getAnimationId]];
	targetIdleAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightIdle Id:[[target getDefinition] getAnimationId]];
	[targetAttackAni retain];
	[targetIdleAni retain];
	
	isRemoteAttack = FALSE;
	for (FDFrameDefinition *frame in [subjectAttackAni getFrameArray]) {
		FDFightFrameDefinition *fightFrame = (FDFightFrameDefinition *)frame;
		if ([fightFrame isRemote]) {
			isRemoteAttack = TRUE;
			break;
		}
	}
	
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
	[subjectSprite setScaleX:1.3 Y:1.3];
	[subjectSprite retain];
	
	// Target
	targetSprite = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Fight-%03d-1-01.png", [[target getDefinition] getAnimationId]]];
	[targetSprite addToLayer:layer];
	[targetSprite setLocation:[FDWindow screenCenter]];
	[targetSprite setScaleX:1.3 Y:1.3];
	[targetSprite retain];
	
	// Creature Bar
	subjectBar = [[CreatureInfoBar alloc] initWithCreature:subject ClickedOn:CGPointMake(0, 0)]; 
	if ([fightingInfo getBackInfo1] == nil) {
		[subjectBar setHp:subject.data.hpCurrent Mp:subject.data.mpCurrent];
	} else {
		[subjectBar setHp:[[fightingInfo getBackInfo1] getBefore] Mp:subject.data.mpCurrent];
	}
	[subjectBar setLocation:[self getBarLocation:subject]];
	[subjectBar show:layer];
	
	// Target Bar
	targetBar = [[CreatureInfoBar alloc] initWithCreature:target ClickedOn:CGPointMake(0, 0)]; 
	[targetBar setHp:[[fightingInfo getAttackInfo1] getBefore] Mp:target.data.mpCurrent];
	[targetBar setLocation:[self getBarLocation:target]];
	[targetBar show:layer];
	
	if (isRemoteAttack) {
		[self setTargetVisible:FALSE];
	}
	
	// Animation
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
	
	if (isRemoteAttack) {
		FDSlideAnimation *ani = [[FDSlideAnimation alloc] initWithDefinition:targetIdleAni Sprite:targetSprite];
		[targetAnimation addAnimation:ani];
		[ani release];		
	} else {
		[self appendIdleAnimation];
	}
}

-(void) appendIdleAnimation
{
	FDSlideAnimation *ani = [[FDSlideAnimation alloc] initWithDefinition:subjectIdleAni Sprite:subjectSprite];
	[subjectAnimation addAnimation:ani];
	[ani release];
	
	ani = [[FDSlideAnimation alloc] initWithDefinition:targetIdleAni Sprite:targetSprite];
	[targetAnimation addAnimation:ani];
	[ani release];
}

-(void) appendSubjectAttackAnimation:(int)tagIndex
{
	FDSlideAnimation *ani = [[FDSlideAnimation alloc] initWithDefinition:subjectAttackAni Sprite:subjectSprite];
	[ani onRenderFrame:@selector(onSubjectAttack:Tag:) Id:self];
	[ani setTagIndex:tagIndex];
	[subjectAnimation addAnimation:ani];
	[ani release];
	
	while ([targetAnimation getDuration] < [subjectAnimation getDuration]) {
		ani = [[FDSlideAnimation alloc] initWithDefinition:targetIdleAni Sprite:targetSprite];
		[targetAnimation addAnimation:ani];
		[ani release];
	}
}

-(void) appendTargetAttackAnimation:(int)tagIndex
{
	FDSlideAnimation *ani = [[FDSlideAnimation alloc] initWithDefinition:targetAttackAni Sprite:targetSprite];
	[ani onRenderFrame:@selector(onTargetAttack:Tag:) Id:self];
	[ani setTagIndex:tagIndex];
	[targetAnimation addAnimation:ani];
	[ani release];
	
	while ([subjectAnimation getDuration] < [targetAnimation getDuration]) {
		ani = [[FDSlideAnimation alloc] initWithDefinition:subjectIdleAni Sprite:subjectSprite];
		[subjectAnimation addAnimation:ani];
		[ani release];
	}
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

-(void) onSubjectAttack:(FDFrameDefinition *)frame Tag:(NSNumber *)tagIndex
{
	FDFightFrameDefinition *fightFrame = (FDFightFrameDefinition *)frame;
	AttackInformation *attackInfo = ([tagIndex intValue] == 1) ? [fightingInfo getAttackInfo1] : [fightingInfo getAttackInfo2];
	
	if (isRemoteAttack)
	{
		if ([fightFrame isRemote]) {
			[self setTargetVisible:FALSE];
			[subjectBar appear];
			[taiSprite setVisible:TRUE];
		} else {
			[self setTargetVisible:TRUE];
			[subjectBar hide];
			[taiSprite setVisible:FALSE];
		}
	}
	
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

-(void) onTargetAttack:(FDFrameDefinition *)frame Tag:(NSNumber *)tagIndex
{
	FDFightFrameDefinition *fightFrame = (FDFightFrameDefinition *)frame;
	AttackInformation *attackInfo = ([tagIndex intValue] == 1) ? [fightingInfo getBackInfo1] : [fightingInfo getBackInfo2];
	
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

// This should not be called
/*
-(void) setSubjectVisible:(BOOL)val
{
	[subjectSprite setVisible:val];
	
	if (val) {
		[subjectBar appear];
	} else {
		[subjectBar hide];
	}
	
	if (![subject getCreatureType] == CreatureType_Enemy) {
		[taiSprite setVisible:val];
	}
}
*/

-(void) setTargetVisible:(BOOL)val
{
	[targetSprite setVisible:val];
	
	if (val) {
		[targetBar appear];
	} else {
		[targetBar hide];
	}
	
	if (![target getCreatureType] == CreatureType_Enemy) {
		[taiSprite setVisible:val];
	}
}

-(void) dealloc
{
	[subject release];
	[target release];
	[fightingInfo release];
	
	[subjectAttackAni release];
	[subjectIdleAni release];
	
	[super dealloc];
}

@end
