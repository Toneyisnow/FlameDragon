//
//  BattleScene.h
//  FlameDragon
//
//  Created by sui toney on 12-10-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDSprite.h"
#import "FDCreature.h"
#import "AnimationDefinition.h"
#import "FDCombinedAnimation.h"
#import "CreatureInfoBar.h"
#import "FightingInformation.h"


@interface BattleScene : CCScene {

	CCLayer *layer;
	FDSprite *taiSprite;

	CreatureInfoBar *subjectBar;
	CreatureInfoBar *targetBar;
	
	int tickCount;

	SEL postMethod;
	id obj1;
	id obj2;
	id object;	
	
	
}

-(id) initWithBackgroundImageId:(int)imageId;

-(void) start;
-(void) setPostMethod:(SEL)sel param1:(id)o1 param2:(id)o2 Obj:(id)obj;


-(CGPoint) getBarLocation:(FDCreature *)creature;
@end
