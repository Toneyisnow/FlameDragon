//
//  TitleLayer.h
//  FlameDragon
//
//  Created by sui toney on 11-12-27.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "CreatureRecord.h"

@interface TitleLayer : CCLayer {

}

//-(CGPoint) startButtonLoc;
-(void) onNewGame;
-(void) onLoadGame;
-(void) onContinueGame;

-(BOOL) clickedOnButton:(CGPoint)buttonLoc At:(CGPoint)clickedLoc;

-(void) loadTestingGame;
-(CreatureRecord *) loadTestingRecord:(int)creatureId level:(int)level;


@end
