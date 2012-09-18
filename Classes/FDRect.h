//
//  FDRect.h
//  FlameDragon
//
//  Created by sui toney on 11-11-24.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"


@interface FDRect : NSObject {

	int posX;
	int posY;
	int width;
	int height;
}

-(id) initWithX:(int)x Y:(int)y Width:(int)w Height:(int)h;

-(BOOL) isIn:(CGPoint)pos;

@end
