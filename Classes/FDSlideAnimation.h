//
//  FDSlideAnimation.h
//  FlameDragon
//
//  Created by sui toney on 11-11-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDAnimation.h"

@interface FDSlideAnimation : FDAnimation {
	
	int currentFrameIndex;
	int currentTick;

	
	id object;
	SEL callback;
}

-(void) onRenderFrame:(SEL)method Id:(id)o;

@end
