//
//  MagicalScene.m
//  FlameDragon
//
//  Created by sui toney on 12-10-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "MagicalScene.h"
#import "DataDepot.h"
#import "FDSpriteStore.h"
#import "FDWindow.h"
#import "FDSlideAnimation.h"
#import "FDFightFrameDefinition.h"
#import "FDFreezeAnimation.h"
#import "FDTransparencyFrameDefinition.h"

@implementation MagicalScene

-(id) initWithMagic:(int)mId Subject:(FDCreature *)sub Targets:(NSArray *)tars Information:(MagicalInformation *)info Background:(int)backgroundImageId
{
	self = [super initWithBackgroundImageId:backgroundImageId];
	
	if (sub == nil || tars == nil || info == nil) {
		NSLog(@"MagicalScene init error: parameter is nil");
		return self;
	}
	
	subject = [sub retain];
	targetList = [tars retain];
	magicalInfo = [info retain];
	magicDefinition = [[DataDepot depot] getMagicDefinition:mId];
	[magicDefinition retain];
	
	subjectAttackAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightAttack Id:[[subject getDefinition] getAnimationId]];
	subjectIdleAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightIdle Id:[[subject getDefinition] getAnimationId]];
	[subjectAttackAni retain];
	[subjectIdleAni retain];
	
    return self;
}

-(void) start
{
	tickCount = 0;
	updatedMp = FALSE;
	[self schedule: @selector(step:)];
	
    	
	// Subject
	subjectSprite = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Fight-%03d-1-01.png", [[subject getDefinition] getAnimationId]]];
	[subjectSprite addToLayer:layer];
	[subjectSprite setLocation:[FDWindow screenCenter]];
	[subjectSprite setScaleX:1.3 Y:1.3];
	[subjectSprite retain];

	// Creature Bar
	subjectBar = [[CreatureInfoBar alloc] initWithCreature:subject ClickedOn:CGPointMake(0, 0)]; 
	[subjectBar setHp:subject.data.hpCurrent Mp:(subject.data.mpCurrent + magicDefinition.mpCost)];
	[subjectBar setLocation:[self getBarLocation:subject]];
	[subjectBar show:layer];
	
	// Target
	FDCreature *target = [targetList objectAtIndex:0];
	AttackInformation *aInfo = [[magicalInfo getInformations] objectAtIndex:0];
	
	targetSprite = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Fight-%03d-1-01.png", [[target getDefinition] getAnimationId]]];
	[targetSprite addToLayer:layer];
	[targetSprite setLocation:[FDWindow screenCenter]];
	[targetSprite setScaleX:1.3 Y:1.3];
	[targetSprite retain];
	
	// Target Bar
	targetBar = [[CreatureInfoBar alloc] initWithCreature:target ClickedOn:CGPointMake(0, 0)]; 
	[targetBar setHp:[aInfo getBefore] Mp:target.data.mpCurrent];
	[targetBar setLocation:[self getBarLocation:target]];
	[targetBar show:layer];
	
	// Target Animation
	targetIdleAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightIdle Id:[[target getDefinition] getAnimationId]];
	[targetIdleAni retain];	
	 
	 // Animation
	 subjectAnimation = [[FDCombinedAnimation alloc] init];
	 targetAnimation = [[FDCombinedAnimation alloc] init];
    
	 [self appendIdleAnimation];

	 [self appendSubjectAttackAnimation];
	 
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
	 
-(void) appendSubjectAttackAnimation
{
    FDSlideAnimation *ani = [[FDSlideAnimation alloc] initWithDefinition:subjectAttackAni Sprite:subjectSprite];
    [ani onRenderFrame:@selector(onSubjectAttack:Tag:) Id:self];
    [ani setTagIndex:0];
    [subjectAnimation addAnimation:ani];
    [ani release];
		
    while ([targetAnimation getDuration] < [subjectAnimation getDuration]) {
        ani = [[FDSlideAnimation alloc] initWithDefinition:targetIdleAni Sprite:targetSprite];
        [targetAnimation addAnimation:ani];
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
    // id info = [magicalInfo getInformations];
    
	AttackInformation *attackInfo = [[magicalInfo getInformations] objectAtIndex:[tagIndex intValue]];
	
	if ([fightFrame isHitting]) {
		
		[self updateMp];
		int nowValue = [attackInfo getBefore] - ([attackInfo getBefore] - [attackInfo getAfter]) * [fightFrame getHittingRate];
			if (nowValue < 0)
				nowValue = 0;
			
			[targetBar setHp:nowValue Mp:-1];
		}
}

-(void) updateMp
{
	if (!updatedMp) {
		[subjectBar setHp:subject.data.hpCurrent Mp:subject.data.mpCurrent];
	}
	updatedMp = TRUE;
}

-(void) dealloc
{
	[subject release];
	[targetList release];
	[magicalInfo release];
	[magicDefinition release];
	
	[subjectAttackAni release];
	[subjectIdleAni release];
	[targetIdleAni release];
    
    [subjectAnimation release];
    [targetAnimation release];
    
	[super dealloc];
}
	 
	 
@end
