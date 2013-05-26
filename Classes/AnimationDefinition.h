//
//  AnimationDefinition.h
//  FlameDragon
//
//  Created by sui toney on 11-11-25.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDFrameDefinition.h"
#import "FDFileStream.h"

typedef	enum AnimationType
{
	AnimationType_Idle,
	AnimationType_MovingLeft,
	AnimationType_MovingUp,
	AnimationType_MovingRight,
	AnimationType_MovingDown,
	AnimationType_Die,
	AnimationType_FightIdle,
	AnimationType_FightAttack,
	AnimationType_FightSkill,
    AnimationType_Magic
	
} AnimationType;

@interface AnimationDefinition : NSObject {

	int identifier;
	AnimationType type;
	
	
	NSMutableArray *frameArray;
	
	bool repeatable;
	
}

+(id) animationWithType:(AnimationType)t Id:(int)i;

+(id) idleAnimation:(int)i;
+(id) moveUpAnimation:(int)i;
+(id) moveDownAnimation:(int)i;
+(id) moveLeftAnimation:(int)i;
+(id) moveRightAnimation:(int)i;
+(id) generateMoveAnimation:(int)iden WithImageIndexes:(int *)imageIndexes Interval:(int)interval;

+(id) dieAnimation:(int)i;

+(id) readFightAnimationFromFile:(FDFileStream *)stream CreatureAniId:(int)creatureAniId Type:(AnimationType)aniType;
+(id) readMagicAnimationFromFile:(FDFileStream *)stream MagicAniId:(int)magicId;

+(int) getMagicAnimationId:(int)magicId isBadGuy:(BOOL)bad;

-(void) addFrame:(FDFrameDefinition *)frame;
-(NSMutableArray *) getFrameArray;

-(void) setRepeatable:(BOOL)val;
-(int) getTickCount;

-(BOOL) isRepeatable;


@end
