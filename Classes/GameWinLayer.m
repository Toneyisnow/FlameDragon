//
//  GameWinLayer.m
//  FlameDragon
//
//  Created by sui toney on 12-1-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "GameWinLayer.h"
#import "FDSprite.h"
#import "TitleScene.h"
#import "FDWindow.h"
#import "FDAudioEngine.h"

@implementation GameWinLayer


-(id) init
{
	self = [super init];
	
	
	//FDSprite *bg = [[FDSprite alloc] initWithString:@"To Be Continue..." Size:20];
	//[bg setLocation:[FDWindow downRight]];
	
	//[self addChild:[bg getSprite]];
	// [bg addToLayer:self];
	
    //[bg release];
    isGoodEnding = FALSE;
    
	return self;
}

-(void) onEnter {
    
    [CCVideoPlayer setDelegate:self];

    // Start Movie
    [CCVideoPlayer setNoSkip:TRUE];
    
    //NSLog(@"IsGoodEnding: %d", isGoodEnding);
    if (isGoodEnding) {
    
        [CCVideoPlayer playMovieWithFile:@"Ending_Farewell.mp4"];
    } else {
    
        [CCVideoPlayer playMovieWithFile:@"Ending_Bad.mp4"];
    }
    
    movieSegment = 1;
}

-(void) setGoodEnding:(BOOL)isGood
{
    isGoodEnding = isGood;
}

-(void) ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	
//	[self onClose];
}

-(void) onClose
{
	CCScene *scene = [TitleScene node];
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
}


-(void) moviePlaybackFinished {
    CCLOG(@"moviePlaybackFinished");
    [[CCDirector sharedDirector] stopAnimation];
    
    if (movieSegment == 1)
    {
        movieSegment = 2;
        [CCVideoPlayer playMovieWithFile:@"Ending_Staff.mp4"];
        
        [FDAudioEngine playEndingMusic];
    }
    else
    {
        [self onClose];
    }
}

-(void) movieStartsPlaying {
    CCLOG(@"movieStartsPlaying");
    [[CCDirector sharedDirector] startAnimation];
}

@end
