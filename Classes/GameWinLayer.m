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

@implementation GameWinLayer


-(id) init
{
	self = [super init];
	
	
	//FDSprite *bg = [[FDSprite alloc] initWithString:@"To Be Continue..." Size:20];
	//[bg setLocation:[FDWindow downRight]];
	
	//[self addChild:[bg getSprite]];
	// [bg addToLayer:self];
	
    //[bg release];
    
	return self;
}

-(void) onEnter {
    
    [CCVideoPlayer setDelegate:self];

    // Start Movie
    [CCVideoPlayer setNoSkip:TRUE];
    [CCVideoPlayer playMovieWithFile:@"Ending_Farewell.mp4"];
    movieSegment = 1;
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
    }
    else
    {
        [self onClose];
    }
}

-(void) movieStartsPlaying {
    CCLOG(@"");
    [[CCDirector sharedDirector] startAnimation];
}

@end
