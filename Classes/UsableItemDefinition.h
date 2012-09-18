//
//  UsableItemDefinition.h
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "ItemDefinition.h"

typedef enum UsableItemType
{
	UsableItemType_Hp = 1,
	UsableItemType_Mp = 2,
	UsableItemType_MaxAp = 3,
	UsableItemType_MaxHp = 4,
	UsableItemType_MaxMp = 5
	
} UsableItemType;

@interface UsableItemDefinition : ItemDefinition {

	// For item
	UsableItemType useType;
	int quantity;
	
}


@property (nonatomic) UsableItemType useType;
@property (nonatomic) int quantity;


-(void) usedBy:(id)obj;


@end
