//
//  MainGameScene.h
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "BattleFieldLayer.h"
#import "MessageLayer.h"
#import "ControlLayer.h"
#import "GameStartInfo.h"
#import "EventLoader.h"

@interface MainGameScene : CCScene {

	BattleFieldLayer *fieldLayer;
	MessageLayer *messageLayer;
	ControlLayer *controlLayer;
	
	ActionLayers *layers;
	
	EventLoader *eventLoader;
}

-(void) loadWithInfo:(GameStartInfo *)info;
-(void) loadWithInfo:(GameStartInfo *)info withSelectedFriends:(NSMutableArray *)selectedList;


@end
