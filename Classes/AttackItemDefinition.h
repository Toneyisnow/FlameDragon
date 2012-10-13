//
//  AttackItemDefinition.h
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "ItemDefinition.h"
#import "FDRange.h"

@interface AttackItemDefinition : ItemDefinition {

	// For Equip item
	int itemCategory;	// For Attack Item: 1：剑 2：斧 3：矛 4：弓 5：爪 6：机械
	// int race;
	
	int ap;
	int hit;
	int ev;
	//int attackScope;
	FDRange *attackRange;
}

@property (nonatomic) int itemCategory;
@property (nonatomic) int ap;
@property (nonatomic) int hit;
@property (nonatomic) int ev;
@property (nonatomic, retain) FDRange *attackRange;

// When this item is equiped, the extra effect
-(void) extraEffectEquipedBy:(id)obj;

@end
