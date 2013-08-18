//
//  MagicalScene2.m
//  FlameDragon
//
//  Created by sui toney on 12-10-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "MagicalScene2.h"
#import "DataDepot.h"
#import "FDSpriteStore.h"
#import "FDWindow.h"
#import "FDSlideAnimation.h"
#import "FDFightFrameDefinition.h"
#import "FDFreezeAnimation.h"
#import "FDTransparencyFrameDefinition.h"
#import "FDMoveByAnimation.h"

@implementation MagicalScene2

-(id) initWithMagic:(int)mId Subject:(FDCreature *)sub Targets:(NSArray *)tars Information:(MagicalInformation *)info Background:(int)backgroundImageId
{
	self = [super initWithBackgroundImageId:backgroundImageId];
	
	if (sub == nil || tars == nil || info == nil) {
		CCLOG(@"MagicalScene init error: parameter is nil");
		return self;
	}
	
	subject = [sub retain];
	targetList = [tars retain];
	magicalInfo = [info retain];
	magicDefinition = [[DataDepot depot] getMagicDefinition:mId];
	[magicDefinition retain];
	
	subjectAttackAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightSkill Id:[[subject getDefinition] getAnimationId]];
	subjectIdleAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightIdle Id:[[subject getDefinition] getAnimationId]];
	[subjectAttackAni retain];
	[subjectIdleAni retain];
	
    
    magicAni = [[DataDepot depot] getMagicAnimationDefinition:101 isBadGuy:([subject getCreatureType]==CreatureType_Enemy)];
	[magicAni retain];
    
    isRemote = FALSE;
    
    if (magicDefinition.identifier == 119) {
        isRemote = TRUE;
    }
    
    return self;
}

-(void) start
{
	tickCount = 0;
	updatedMp = FALSE;
    showingMagic = NO;
    switchingTarget = NO;
    currentTargetIndex = 0;
    
	[self schedule: @selector(step:)];
	
    // Magic
    magicSprite = [[FDSpriteStore instance] sprite:@"Empty.png"];
    [magicSprite addToLayer:layer];
    [magicSprite retain];
    
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
	FDCreature *lasttarget = [targetList lastObject];
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
    lasttargetIdleAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightIdle Id:[[lasttarget getDefinition] getAnimationId]];
	[lasttargetIdleAni retain];
    
	 // Animation
	 subjectAnimation = [[FDCombinedAnimation alloc] init];
	 targetAnimation = [[FDCombinedAnimation alloc] init];
     lasttargetAnimation = [[FDCombinedAnimation alloc] init];
     magicAnimation = [[FDSlideAnimation alloc] initWithDefinition:magicAni Sprite:magicSprite];
     [magicAnimation onRenderFrame:@selector(onMagicAttack:Tag:) Id:self];
	
    targetSwitchAnimation = [[FDCombinedAnimation alloc] init];
    
    FDMoveByAnimation *a1 = [[FDMoveByAnimation alloc] initWithDelta:CGPointMake(-240, 0) WithTick:20 Sprite:targetSprite];
    FDMoveByAnimation *a2 = [[FDMoveByAnimation alloc] initWithDelta:CGPointMake(240, 0) WithTick:20 Sprite:targetSprite];
    
    if ([subject getCreatureType] == CreatureType_Enemy) {
        [targetSwitchAnimation addAnimation:a2];
        [targetSwitchAnimation addAnimation:a1];
    } else {
        [targetSwitchAnimation addAnimation:a1];
        [targetSwitchAnimation addAnimation:a2];
    }
    [a1 release];
    [a2 release];
    
    if (isRemote) {
        [self setTargetVisible:FALSE];
    }
    
    [self appendIdleAnimation];
    [self appendSubjectAttackAnimation];
    [self appendLastIdleAnimation];
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

-(void) appendLastIdleAnimation
{
    FDSlideAnimation *ani;
    
    if (!isRemote) {
        ani = [[FDSlideAnimation alloc] initWithDefinition:subjectIdleAni Sprite:subjectSprite];
        [subjectAnimation addAnimation:ani];
        [ani release];
    }
    
	ani = [[FDSlideAnimation alloc] initWithDefinition:lasttargetIdleAni Sprite:targetSprite];
	[lasttargetAnimation addAnimation:ani];
	[ani release];
}

-(void) appendSubjectAttackAnimation
{
    FDSlideAnimation *ani = [[FDSlideAnimation alloc] initWithDefinition:subjectAttackAni Sprite:subjectSprite];
    [ani onRenderFrame:@selector(onSubjectAttack:Tag:) Id:self];
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
	
    if (showingMagic) {
        [self tickMagic];
        return;
    }
    
    if (switchingTarget) {
        [self tickSwitching];
        return;
    }
    
	[subjectAnimation takeTick:tickCount];
    
    if (currentTargetIndex < [targetList count] - 1) {
        [targetAnimation takeTick:tickCount];
    } else {
        [lasttargetAnimation takeTick:tickCount];
    }
	
	if ([subjectAnimation hasFinished] && [lasttargetAnimation hasFinished]) {
		
		[[CCDirector sharedDirector] popScene];
		// Perform post method
		[object performSelector:postMethod withObject:obj1 withObject:obj2];
	}
}

-(void) tickMagic {
    
    if (isRemote) {
        [self setTargetVisible:TRUE];
    }
    
    [magicAnimation takeTick:tickCount];
    if ([magicAnimation hasFinished]) {
        
        showingMagic = NO;
        
        if (currentTargetIndex < [targetList count] - 1) {
            
            [targetSwitchAnimation reset];
            switchingTarget = YES;
        } else {
            switchingTarget = NO;
        }
    }
}

-(void) tickSwitching {
    
    [targetSwitchAnimation takeTick:tickCount];
    
    if ([targetSwitchAnimation hasFinished]) {
        
        CCLOG(@"Switch Finished.");
        
        switchingTarget = NO;
        
        [magicAnimation reset];
        showingMagic = YES;
        return;
    }
    
    if ([targetSwitchAnimation isAnimationSwitched]) {
        
        CCLOG(@"AnimationSwitched");
        // Update the Target Index
        currentTargetIndex++;
        
        if (currentTargetIndex < [targetList count]) {
            
            // Update Target Sprite
            FDCreature *target = [targetList objectAtIndex:currentTargetIndex];
            FDImage *image = [[FDSpriteStore instance] image:[NSString stringWithFormat:@"Fight-%03d-1-01.png", [[target getDefinition] getAnimationId]]];
            [targetSprite setImage:image];
            
            // Update Target Bar
            AttackInformation *aInfo = [[magicalInfo getInformations] objectAtIndex:currentTargetIndex];
            
            [targetBar setCreature:target];
            [targetBar setHp:[aInfo getBefore] Mp:target.data.mpCurrent];
        }
    }
}

-(void) onSubjectAttack:(FDFrameDefinition *)frame Tag:(NSNumber *)tagIndex
{
    // This should only be called once during the animation, that means the Subject Animation
    // should have only one frame with 100 defined
    if (updatedMp) {
        return;
    }
    
	FDFightFrameDefinition *fightFrame = (FDFightFrameDefinition *)frame;
	if ([fightFrame isHitting]) {
		
		[self updateMp];
        
        // Init magic
        [magicAnimation reset];
        showingMagic = YES;
    }
}

-(void) onMagicAttack:(FDFrameDefinition *)frame Tag:(NSNumber *)tagIndex
{
    FDFightFrameDefinition *fightFrame = (FDFightFrameDefinition *)frame;
	AttackInformation *attackInfo = [[magicalInfo getInformations] objectAtIndex:currentTargetIndex];
	
	if ([fightFrame isHitting]) {
    
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

-(void) setTargetVisible:(BOOL)val
{
	[targetSprite setVisible:val];
	
	if (val) {
		[targetBar appear];
        [subjectBar hide];
	} else {
		[targetBar hide];
        [subjectBar appear];
	}
	
	if ([subject getCreatureType] == CreatureType_Friend) {
		[taiSprite setVisible:!val];
	} else {
		[taiSprite setVisible:val];
	}
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
	[lasttargetIdleAni release];
    
    [magicAni release];
    [magicSprite release];
    
    [subjectAnimation release];
    [targetAnimation release];
    [lasttargetAnimation release];
    [magicAnimation release];
    [targetSwitchAnimation release];
        
	[super dealloc];
}
	 
@end
