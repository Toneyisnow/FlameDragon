//
//  FightingScene.h
//  FlameDragon
//
//  Created by sui toney on 12-10-18.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "BattleScene.h"

@interface FightingScene : BattleScene {

	
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
	
	BOOL isRemoteAttack;
	
}

-(id) initWithSubject:(FDCreature *)sub Target:(FDCreature *)tar Information:(FightingInformation *)info Background:(int)backgroundImageId;

-(void) onSubjectAttack:(FDFrameDefinition *)frame Tag:(NSNumber *)tagIndex;
-(void) onTargetAttack:(FDFrameDefinition *)frame Tag:(NSNumber *)tagIndex;

-(void) start;
-(void) setPostMethod:(SEL)sel param1:(id)o1 param2:(id)o2 Obj:(id)obj;

// -(void) setSubjectVisible:(BOOL)val;
-(void) setTargetVisible:(BOOL)val;

-(void) appendIdleAnimation;
-(void) appendSubjectAttackAnimation:(int)tag;
-(void) appendTargetAttackAnimation:(int)tag;


@end
