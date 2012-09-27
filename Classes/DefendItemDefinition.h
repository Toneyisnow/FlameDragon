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

	// For Defend Item: 1：皮甲 2：锁甲 3：铠甲 4：袍 5：斗服 6：装甲
	int itemCategory;
	
	int race;
	
	int dp;
	int ev;
	
}

@property (nonatomic) int itemCategory;
@property (nonatomic) int dp;
@property (nonatomic) int ev;

-(void) extraEffectEquipedBy:(id)obj;

@end
