//
//  MagicalScene.m
//  FlameDragon
//
//  Created by sui toney on 12-10-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "MagicalScene.h"


@implementation MagicalScene

-(id) initWithSubject:(FDCreature *)sub Targets:(NSArray *)tars Information:(MagicalInformation *)info Background:(int)backgroundImageId
{
	self = [super initWithBackgroundImageId:backgroundImageId];
	
	if (sub == nil || tars == nil || info == nil) {
		NSLog(@"MagicalScene init error: parameter is nil");
		return self;
	}
	
	subject = [sub retain];
	targetList = [tars retain];
	magicalInfo = [info retain];
	
	subjectAttackAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightAttack Id:[[subject getDefinition] getAnimationId]];
	subjectIdleAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightIdle Id:[[subject getDefinition] getAnimationId]];
	[subjectAttackAni retain];
	[subjectIdleAni retain];
	
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

	// Creature Bar
	subjectBar = [[CreatureInfoBar alloc] initWithCreature:subject ClickedOn:CGPointMake(0, 0)]; 
	[subjectBar setHp:subject.data.hpCurrent Mp:subject.data.mpCurrent];
	[subjectBar setLocation:[self getBarLocation:subject];
	[subjectBar show:layer];
	
	// Target
	FDCreature *target = [targetList objectAtIndex:0];
	AttackInformation *aInfo = [[magicalInfo getInformations] objectAtIndex:0];
	
	targetSprite = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Fight-%03d-1-01.png", [[target getDefinition] getAnimationId]]];
	[targetSprite addToLayer:layer];
	[targetSprite setLocation:[FDWindow screenCenter]];
	[targetSprite retain];
	
	// Target Bar
	targetBar = [[CreatureInfoBar alloc] initWithCreature:target ClickedOn:CGPointMake(0, 0)]; 
	[targetBar setHp:[aInfo getBefore] Mp:target.data.mpCurrent];
	[targetBar setLocation:[self getBarLocation:target]];
	[targetBar show:layer];
	
	 
	 // Animation
	 subjectAnimation = [[FDCombinedAnimation alloc] init];
	 targetAnimation = [[FDCombinedAnimation alloc] init];
	 
	 [self appendIdleAnimation];

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
	 

@end
