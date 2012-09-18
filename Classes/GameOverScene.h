//
//  GameOverScene.h
//  FlameDragon
//
//  Created by sui toney on 12-1-13.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"


@interface GameOverScene : CCScene {

	int tickCount;
}

-(void) closeScene;
-(void) step: (ccTime) delta;

@end
