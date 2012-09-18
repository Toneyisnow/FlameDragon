//
//  HelloWorldLayer.h
//  FlameDragon
//
//  Created by sui toney on 11-11-2.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "BattleField.h"
#import "ActionDispatcher.h"

@interface HelloWorldLayer : CCLayer {

	CGPoint originPos;
	CGPoint clickCenter;
	
	CCSprite *sprite;
	CCSprite *icon;
	
	CCTexture2D *texture1;
	CCTexture2D *texture2;
	CCTexture2D *texture3;
	CCTexture2D *texture4;

	BattleField *field;
	ActionDispatcher *dispatcher;
	
	
	int iconStatus;
	
	int tickCount;
	
	bool isTouchMoved;
}

-(void) updateScreen;

@end
