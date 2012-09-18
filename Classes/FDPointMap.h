//
//  FDPointMap.h
//  FlameDragon
//
//  Created by sui toney on 11-11-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"


@interface FDPointMap : NSObject {

	CGPoint *map;
	int width;
	int height;
	
}

-(id) initWidth:(int)w Height:(int)h;

-(void) setX:(int)x Y:(int)y Value:(CGPoint)val;

-(CGPoint) getX:(int)x Y:(int)y;

@end
