//
//  DefendItemDefinition.h
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ItemDefinition.h"

@interface DefendItemDefinition : ItemDefinition {

	// For Equip item
	int race;
	int dp;
	int ev;
	
}

@property (nonatomic) int race;
@property (nonatomic) int dp;
@property (nonatomic) int ev;

-(void) extraEffectEquipedBy:(id)obj;

@end
