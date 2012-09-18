//
//  FDIntMap.h
//  FlameDragon
//
//  Created by sui toney on 11-11-9.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"


@interface FDIntMap : NSObject {

	int *map;
	int width;
	int height;
}

-(id) initWidth:(int)w Height:(int)h;

-(void) setX:(int)x Y:(int)y Value:(int)val;

-(int) getX:(int)x Y:(int)y;

@end
