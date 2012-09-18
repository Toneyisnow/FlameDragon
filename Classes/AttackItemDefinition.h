//
//  AttackItemDefinition.h
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "ItemDefinition.h"


@interface AttackItemDefinition : ItemDefinition {

	// For Equip item
	int race;
	
	int ap;
	int hit;
	int ev;
	int attackScope;
	
}

@property (nonatomic) int race;
@property (nonatomic) int ap;
@property (nonatomic) int hit;
@property (nonatomic) int ev;
@property (nonatomic) int attackScope;

// When this item is equiped, the extra effect
-(void) extraEffectEquipedBy:(id)obj;

@end
