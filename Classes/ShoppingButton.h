//
//  ShoppingButton.h
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDSprite.h"

@interface ShoppingButton : NSObject {

	FDSprite *image;
	CGPoint location;
	
	id  cbObj;
	SEL cbMethod;
}

-(id) initWithSprite:(FDSprite *)img Location:(CGPoint)loc;
-(id) initWithSprite:(FDSprite *)img;
-(void) setLocation:(CGPoint)loc;

-(void) setCallback:(id)obj Method:(SEL)m;

-(BOOL) isClicked:(CGPoint)loc;

-(void) onClick;

-(FDSprite *) getSprite;

@end
