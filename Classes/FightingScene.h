//
//  FightingScene.h
//  FlameDragon
//
//  Created by sui toney on 12-10-18.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDSprite.h"
#import "FDCreature.h"
#import "AnimationDefinition.h"
#import "FDCombinedAnimation.h"
#import "CreatureInfoBar.h"
#import "FightingInformation.h"

@interface FightingScene : CCScene {

	CCLayer *layer;
	
	FightingInformation *fightingInfo;
	
	FDCreature *subject;
	FDCreature *target;
	
	// UI
	FDSprite *subjectSprite;
	FDSprite *targetSprite;

	AnimationDefinition *subjectAttackAni;
	AnimationDefinition *subjectIdleAni;
	FDCombinedAnimation *subjectAnimation;
	
	AnimationDefinition *targetAttackAni;
	AnimationDefinition *targetIdleAni;
	FDCombinedAnimation *targetAnimation;
	
	CreatureInfoBar *subjectBar;
	CreatureInfoBar *targetBar;
	
	int tickCount;
	
	
	SEL postMethod;
	id obj1;
	id obj2;
	id object;	
	
}

-(id) initWithSubject:(FDCreature *)sub Target:(FDCreature *)tar Information:(FightingInformation *)info Background:(int)backgroundImageId;

-(void) onSubjectAttack:(FDFrameDefinition *)frame Tag:(int)tagIndex;
-(void) onTargetAttack:(FDFrameDefinition *)frame Tag:(int)tagIndex;

-(void) start;
-(void) setPostMethod:(SEL)sel param1:(id)o1 param2:(id)o2 Obj:(id)obj;

-(void) appendIdleAnimation;
-(void) appendSubjectAttackAnimation:(int)tag;
-(void) appendTargetAttackAnimation:(int)tag;


@end
