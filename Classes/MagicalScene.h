//
//  MagicalScene.h
//  FlameDragon
//
//  Created by sui toney on 12-10-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "BattleScene.h"

@interface MagicalScene : BattleScene {

	CCLayer *layer;

	MagicalInformation *magicalInfo;
	
	FDCreature *subject;
	NSArray *targetList;

	// UI
	FDSprite *subjectSprite;
	FDSprite *targetSprite;
	
	FDSprite *taiSprite;
	
	AnimationDefinition *subjectAttackAni;
	AnimationDefinition *subjectIdleAni;
	FDCombinedAnimation *subjectAnimation;
	
	AnimationDefinition *targetIdleAni;
	FDCombinedAnimation *targetAnimation;
	
	CreatureInfoBar *subjectBar;
	CreatureInfoBar *targetBar;
	
	int tickCount;
	BOOL isRemoteAttack;
	
	SEL postMethod;
	id obj1;
	id obj2;
	id object;	
	
	
}



@end
