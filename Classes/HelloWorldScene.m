//
//  HelloWorldLayer.m
//  FlameDragon
//
//  Created by sui toney on 11-11-1.
//  Copyright ms 2011. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "HelloWorldLayer.h"

// HelloWorld implementation
@implementation HelloWorldScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [HelloWorldScene node];
	
	
	// return the scene
	return scene;
}

-(id) init
{
	self = [super init];
	
	// 'layer' is an autorelease object.
	mainLayer = [HelloWorldLayer node];
	
	mainLayer.isTouchEnabled = TRUE;
	
	// add layer as a child to scene
	[self addChild: mainLayer];
	[self schedule: @selector(step:)];
	
	gameTick = 0;
	
	return self;
}


-(void) step: (ccTime) delta
{
	gameTick ++;
	
	// NSLog(@"Scene tick");
	[mainLayer updateScreen];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
