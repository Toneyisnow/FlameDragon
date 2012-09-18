//
//  BattleFieldLayer.h
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "BattleField.h"

@interface BattleFieldLayer : CCLayer {

	BattleField *field;
	
}

-(void) loadChapter:(int)chapterId;
-(void) updateScreen:(int)synchronizeTick;
-(BattleField *) getField;


@end
