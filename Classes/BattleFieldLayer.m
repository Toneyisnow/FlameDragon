//
//  BattleFieldLayer.m
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "BattleFieldLayer.h"
#import "Constants.h"

@implementation BattleFieldLayer

-(id) init
{
	if( (self=[super init] )) {
		
		// ask director the the window size
		//CGSize size = [[CCDirector sharedDirector] winSize];
		

	}
	return self;
}

-(void) loadChapter:(int)chapterId
{
	field = [[BattleField alloc] initWithChapter:chapterId];
	
	// position the label on the center of the screen
	//[field getSprite].position =  ccp( size.width /2 , size.height/2);
	[[field getSprite] setScaleX:[Constants battleMapScale] Y:[Constants battleMapScale]];
	
	// add the label as a child to this Layer
	[[field getSprite] addToLayer:self];
	
}

-(BattleField *) getField
{
	return field;
}

-(void) updateScreen:(int)synchronizeTick
{
	[field takeTick:synchronizeTick];
}

@end
