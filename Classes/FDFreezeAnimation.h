//
//  FDFreezeAnimation.h
//  FlameDragon
//
//  Created by sui toney on 12-10-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "FDAnimation.h"


@interface FDFreezeAnimation : FDAnimation {

	int currentTick;
	int freezeTick;
}

-(id) initWithTickCount:(int)t Sprite:(FDSprite *)c;

@end
