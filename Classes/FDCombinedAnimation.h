//
//  FDCombinedAnimation.h
//  FlameDragon
//
//  Created by sui toney on 11-11-27.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDAnimation.h"

@interface FDCombinedAnimation : FDAnimation {

	
	NSMutableArray *animationList;
	int aniIndex;
	
}

-(void) addAnimation:(FDAnimation *)ani;



@end
