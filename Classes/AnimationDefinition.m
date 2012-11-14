//
//  AnimationDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-11-25.
//  Copyright 2011 ms. All rights reserved.
//

#import "AnimationDefinition.h"
#import "Constants.h"
#import "FDSetImageFrameDefinition.h"
#import "FDFightFrameDefinition.h"

@implementation AnimationDefinition

+(id) animationWithType:(AnimationType)t Id:(int)i
{
	switch (t) {
		case AnimationType_Idle:
			return [self idleAnimation:i];
			break;
		case AnimationType_MovingUp:
			return [self moveUpAnimation:i];
			break;
		case AnimationType_MovingDown:
			return [self moveDownAnimation:i];
			break;
		case AnimationType_MovingLeft:
			return [self moveLeftAnimation:i];
			break;
		case AnimationType_MovingRight:
			return [self moveRightAnimation:i];
			break;
		case AnimationType_Die:
			return [self dieAnimation:i];
			break;
		default:
			NSLog(@"Cannot generate animation with type=%d identity=%d, this animation must be generated from file.", t, i);
			return nil;
			break;
	}
	return nil;
}

+(id) idleAnimation:(int)i
{
	return [self generateMoveAnimation:i WithImageIndexes:(int[]){1,2,3,2} Interval:500];
}

+(id) moveUpAnimation:(int)i
{
	return [self generateMoveAnimation:i WithImageIndexes:(int[]){7,8,9,8} Interval:200];
}

+(id) moveDownAnimation:(int)i
{	
	return [self  generateMoveAnimation:i WithImageIndexes:(int[]){1,2,3,2} Interval:200];
}

+(id) moveLeftAnimation:(int)i
{
	return [self generateMoveAnimation:i WithImageIndexes:(int[]){4,5,6,5} Interval:200];
}

+(id) moveRightAnimation:(int)i
{
	return [self generateMoveAnimation:i WithImageIndexes:(int[]){10,11,12,11} Interval:200];
}

+(id) generateMoveAnimation:(int)iden WithImageIndexes:(int *)imageIndexes Interval:(int)interval
{
	AnimationDefinition *animationDef = [[AnimationDefinition alloc] init];
	
	for (int i = 0; i < sizeof(imageIndexes); i++) {
		
		NSString *spriteFile = [NSString stringWithFormat:@"Icon-%03d-%02d.png", iden, *(imageIndexes+i)];
		FDSetImageFrameDefinition *frame = [[FDSetImageFrameDefinition alloc] initFromFile:spriteFile Time:interval];
		[animationDef addFrame:frame];
		[frame release];
	}
	
	return [animationDef autorelease];
}

+(id) dieAnimation:(int)iden
{
	int interval = 180;
	AnimationDefinition *animationDef = [[AnimationDefinition alloc] init];
	
	for (int i = 0; i < 3; i++) {
		
		for (int k = 2; k < 12; k += 3) {
			NSString *spriteFile = [NSString stringWithFormat:@"Icon-%03d-%02d.png", iden, k];
			FDSetImageFrameDefinition *frame = [[FDSetImageFrameDefinition alloc] initFromFile:spriteFile Time:interval];
			[animationDef addFrame:frame];
			[frame release];
		}
	}
	
	for (int i = 1; i <= 8; i++) {
		NSString *spriteFile = [NSString stringWithFormat:@"Explode-%02d.png", i];
		FDSetImageFrameDefinition *frame = [[FDSetImageFrameDefinition alloc] initFromFile:spriteFile Time:interval];
		[animationDef addFrame:frame];
		[frame release];
	}
	
	[animationDef setRepeatable:FALSE];
	return [animationDef autorelease];
	
}

+(id) readFightAnimationFromFile:(FDFileStream *)stream CreatureAniId:(int)creatureAniId Type:(AnimationType)aniType
{
	AnimationDefinition *aniDef = [[AnimationDefinition alloc] init];
	
	[aniDef setRepeatable:FALSE];
	
	int frameCount = [stream readInt];
	int aniTypeInt = 1;
	switch (aniType) {
		case AnimationType_FightIdle:
			aniTypeInt = 1;
			break;
		case AnimationType_FightAttack:
			aniTypeInt = 2;
			break;
		case AnimationType_FightSkill:
			aniTypeInt = 3;
			break;
		default:
			
			NSLog(@"Parameter error: cannot read Fight Animation with type %d.", aniType);
			break;
	}
	
	int hitArray[frameCount];
	int remoteFrameIndex = 0;
	
	if (aniType == AnimationType_FightAttack) {
		
		int next = [stream readInt];
		int index = 1;
		while (next != -1) {
			hitArray[index - 1] = next;
			index ++;
			next = [stream readInt];
		}
	}
	
	for (int i = 1; i <= frameCount; i++) {
		
	}
	
	if (aniType == AnimationType_FightAttack) {
		remoteFrameIndex = [stream readInt];
	}
	
	for (int i = 1; i <= frameCount; i++) {
		
		NSString *spriteFile = [NSString stringWithFormat:@"Fight-%03d-%d-%02d.png", creatureAniId, aniTypeInt, i];
	
		int interval = 2 * [Constants fightAnimationIntervalUnit];
		int soundId = 0;
		BOOL isRemote = (i <= remoteFrameIndex);
		double hittingRate = (aniType == AnimationType_FightAttack) ? hitArray[i - 1] / 100.0 : 0;
		
		FDFightFrameDefinition *frame = [[FDFightFrameDefinition alloc] initFromFile:spriteFile Time:interval Sound:soundId Remote:isRemote Hitting:hittingRate];

		[aniDef addFrame:frame];
		[frame release];
	}
	
	return [aniDef autorelease];
}

-(id) init
{
	self = [super init];
	
	frameArray = [[NSMutableArray alloc] init];
	repeatable = TRUE;
	
	return self;
}

-(void) addFrame:(FDFrameDefinition *)frame
{
	[frameArray addObject:frame];
}

-(NSMutableArray *) getFrameArray
{
	return frameArray;
}

-(int) getTickCount
{
	int total = 0;
	for (FDFrameDefinition *frame in frameArray)
	{
		total += frame.tickCount;
	}
	return total;
}

-(BOOL) isRepeatable
{
	return repeatable;
}

-(void) setRepeatable:(BOOL)val
{
	repeatable = val;
}


@end
