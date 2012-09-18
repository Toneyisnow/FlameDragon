//
//  FightScene.h
//  FlameDragon
//
//  Created by sui toney on 11-11-24.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
//#import "FightTargetInfo.h"
#import "FDSprite.h"
#import "FDCreature.h"
#import "AnimationDefinition.h"
#import "FDCombinedAnimation.h"
#import "CreatureInfoBar.h"

@interface FightScene : CCScene	{

	CCScene *previous;
	CGSize screenSize;
	
	
	
	int tickCount;
	
	CCLayer *layer;
	
	// Information needed
	int backgroundId;
	//FightTargetInfo *selfInfo;
	//NSMutableArray *targetsInfo;
	
	FDCreature *creature;
	NSMutableArray *targets;
	
	BOOL fightBack;
	
	
	// UI
	FDSprite *background;
	FDSprite *tai;
	
	FDSprite *subject;
	AnimationDefinition *subjectAttackAni;
	AnimationDefinition *subjectIdleAni;
	FDCombinedAnimation *creatureAnimation;
	
	FDSprite *targetObject;
	NSMutableArray *objects;
	AnimationDefinition *targetAttackAni;
	AnimationDefinition *targetIdleAni;
	FDCombinedAnimation *targetAnimation;
	
	CreatureInfoBar *subjectBar;
	CreatureInfoBar *targetBar;
	
	SEL postMethod;
	id obj1;
	id obj2;
	id object;	
}

-(void) setPrevious:(CCScene *)previous;
-(void) setParameter:(int)background Self:(FDCreature *)creature Targets:(NSMutableArray *)targets FightBack:(BOOL)back;
-(void) setPostMethod:(SEL)sel param1:(id)o1 param2:(id)o2 Obj:(id)obj;
-(void) start;

-(void) onSubjectAttack:(FDFrameDefinition *)frame;
-(void) onTargetAttack:(FDFrameDefinition *)frame;

-(CGPoint) friendBarPos;
-(CGPoint) enemyBarPos;


@end
