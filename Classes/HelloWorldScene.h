//
//  HelloWorldLayer.h
//  FlameDragon
//
//  Created by sui toney on 11-11-1.
//  Copyright ms 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "HelloWorldLayer.h"

// HelloWorld Layer
@interface HelloWorldScene : CCScene
{	
	
	int gameTick;
	HelloWorldLayer *mainLayer;
	
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

-(void) step: (ccTime) delta;

@end
