//
//  GameWinLayer.h
//  FlameDragon
//
//  Created by sui toney on 12-1-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "CCVideoPlayer.h"

@interface GameWinLayer : CCLayer<CCVideoPlayerDelegate> {

    int movieSegment;
}

-(void) onClose;

@end
