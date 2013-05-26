//
//  MagicalScene2.h
//  FlameDragon
//
//  Created by sui toney on 12-10-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "BattleScene.h"
#import "MagicalInformation.h"
#import "MagicDefinition.h"
#import "FDSlideAnimation.h"

@interface MagicalScene2 : BattleScene {

	MagicalInformation *magicalInfo;
	MagicDefinition *magicDefinition;
	
	FDCreature *subject;
	NSArray *targetList;

	// UI
	FDSprite *subjectSprite;
	FDSprite *targetSprite;
	FDSprite *magicSprite;
    
	AnimationDefinition *subjectAttackAni;
	AnimationDefinition *subjectIdleAni;
	FDCombinedAnimation *subjectAnimation;
	
	AnimationDefinition *targetIdleAni;
	AnimationDefinition *lasttargetIdleAni;
	FDCombinedAnimation *targetAnimation;
	FDCombinedAnimation *lasttargetAnimation;
	FDCombinedAnimation *targetSwitchAnimation;
	
    
    AnimationDefinition *magicAni;
    FDSlideAnimation *magicAnimation;
    
    AnimationDefinition *magicAppearAnimation;
    AnimationDefinition *magicDisappearAnimation;
    
	BOOL updatedMp;
    
    BOOL showingMagic;
    BOOL switchingTarget;
    
    int currentTargetIndex;
}

-(id) initWithMagic:(int)mId Subject:(FDCreature *)sub Targets:(NSArray *)tars Information:(MagicalInformation *)info Background:(int)backgroundImageId;

-(void) appendIdleAnimation:(AnimationDefinition *)def;
-(void) appendSubjectAttackAnimation;

-(void) updateMp;
@end
