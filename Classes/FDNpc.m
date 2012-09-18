//
//  FDNpc.m
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDNpc.h"

@implementation FDNpc

-(id) initWithDefinition:(int)identity Id:(int)i
{
	return [self initWithDefinition:identity Id:i Data:nil];
}

-(id) initWithDefinition:(int)identity Id:(int)i Data:(CreatureData*)dat
{
	self = [super initWithDefinition:identity Id:i Data:dat];
	creatureType = CreatureType_Npc;
	return self;
}

-(id) initWithSavedState:(int)record
{
	self = [super init];
	return self;
}

-(id) initWithCreature:(FDCreature *)creature
{
	int defId = [[creature getDefinition] getId];
	int Id = [creature getIdentifier];
	
	self = [self initWithDefinition:defId Id:Id];
	
	data = [[creature.data clone] retain];
	
	/*hpMax = creature.hpMax;
	mpMax = creature.mpMax;
	hpCurrent = creature.hpCurrent;
	mpCurrent = creature.mpCurrent;
	
	ap = creature.ap;
	dp = creature.dp;
	dx = creature.dx;
	mv = creature.mv;
	
	attackRange = [creature attackRange];
	
	itemList = creature.itemList;
	magicList = creature.magicList;
	
	attackItemIndex = creature.attackItemIndex;
	defendItemIndex = creature.defendItemIndex;
	*/
	
	return self;
}

@end
