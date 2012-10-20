//
//  FDAnimation.h
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDSprite.h"
#import "AnimationDefinition.h"

@interface FDAnimation : NSObject {

	AnimationDefinition *definition;
	
	FDSprite *sprite;

	int tagIndex;

	BOOL finished;
}

-(id) initWithDefinition:(AnimationDefinition *)def Sprite:(FDSprite *)c;

-(void) setTagIndex:(int)t;

-(void) takeTick:(int)synchronizeTick;

-(BOOL) hasFinished;

-(int) getDuration;

-(void) reset;

@end
