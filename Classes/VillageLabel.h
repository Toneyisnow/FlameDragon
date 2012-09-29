//
//  VillageLabel.h
//  FlameDragon
//
//  Created by sui toney on 12-9-29.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "IBar.h"

@interface VillageLabel : IBar {

	int currentPositionIndex;
	
	FDSprite *labelSprite;
}

-(void) setPositionIndex:(int)posIndex;


@end
