//
//  LoadingLayer.h
//  FlameDragon
//
//  Created by sui toney on 12-10-2.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDSprite.h"

@interface LoadingLayer : CCLayer {

	FDSprite *baseSprite;
}

-(void) onLoadRecord:(id)sender;
-(void) doLoadRecord:(int)index;
-(void) onBack:(id)sender;

@end
