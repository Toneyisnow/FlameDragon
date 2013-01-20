//
//  FDEnemy.h
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDCreature.h"

@interface FDEnemy : FDCreature {

	// int dropItemId; // This has been moved to CreatureData
	
}

// +(FDEnemy *) createEnemyWithId:(int) identifier;

-(id) initWithDefinition:(int)identity Id:(int)i;
-(id) initWithDefinition:(int)identity Id:(int)i DropItem:(int)dId;
-(id) initWithDefinition:(int)identity Id:(int)i Data:(CreatureData *)dat;
-(id) initWithSavedState:(int)record;

-(void) setDropItem:(int)itemId;
-(int) getDropItem;

@end
