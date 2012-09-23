//
//  IBar.h
//  FlameDragon
//
//  Created by sui toney on 11-12-4.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDSprite.h"

@interface IBar : NSObject {

	FDSprite *baseSprite;
}

-(void) show:(CCLayer *)layer;
-(void) close;
-(void) hide;
-(void) appear;

-(void) takeTick:(int)synchronizedTick;

-(BOOL) isClicked:(CGPoint)loc;

-(void) clickedOn:(CGPoint)location;
-(void) setLocation:(CGPoint)location;
-(CGPoint) getInnerLocation:(CGPoint)location;



@end
