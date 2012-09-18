//
//  FDScopeIndicator.h
//  FlameDragon
//
//  Created by sui toney on 11-11-8.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDBattleObject.h"
#import "FDAnimation.h"
#import "AnimationDefinition.h"



@interface FDScopeIndicator : FDBattleObject {

	AnimationDefinition *animationDef;
	
	FDAnimation *animation;
}

@end
