//
//  FDEnemy.m
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDEnemy.h"


@implementation FDEnemy

-(id) initWithDefinition:(int)identity Id:(int)i DropItem:(int)itemId
{
	self = [self initWithDefinition:identity Id:i Data:nil];
	dropItemId = itemId;
	return self;
}

-(id) initWithDefinition:(int)identity Id:(int)i
{
	return [self initWithDefinition:identity Id:i Data:nil];
}

-(id) initWithDefinition:(int)identity Id:(int)i Data:(CreatureData*)dat
{
	self = [super initWithDefinition:identity Id:i Data:dat];
	creatureType = CreatureType_Enemy;
	return self;
}

-(id) initWithSavedState:(int)record
{
	self = [super init];
	return self;
}

-(void) setDropItem:(int)itemId
{
	dropItemId = itemId;
}

-(int) getDropItem
{
	return dropItemId;
}

/*
+(FDEnemy *) createEnemyWithId:(int) identifier
{
	FDCreatureDefinition *definition = [FDCreatureDefinition definitionWithId:identifier];
	FDEnemy *friend = [[FDEnemy alloc] initWithDefinition:definition];
	
	return [friend autorelease];
}
*/
@end
