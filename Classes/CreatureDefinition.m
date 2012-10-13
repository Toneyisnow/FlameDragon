//
//  CreatureDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-11-24.
//  Copyright 2011 ms. All rights reserved.
//

#import "CreatureDefinition.h"
#import "FDLocalString.h"
#import "DataDepot.h"
#import "AttackItemDefinition.h"
#import "DefendItemDefinition.h"

@implementation CreatureDefinition

@synthesize name;
@synthesize identifier, race, occupation;

@synthesize data;

-(id) init
{
	self = [super init];
	data = [[CreatureData alloc] init];
	return self;
}

+(id) readFromFile:(FDFileStream *)stream
{
	CreatureDefinition * def = [[CreatureDefinition alloc] init];

	def.identifier = [stream readInt];
	
	
	def.name = [FDLocalString creature:def.identifier];
	
	def.race = [stream readInt];
	def.occupation = [stream readInt];
	def.data.level = [stream readInt];
	def.data.ap = [stream readInt];
	def.data.dp = [stream readInt];
	def.data.dx = [stream readInt];
	def.data.hpCurrent = def.data.hpMax = [stream readInt];
	def.data.mpCurrent = def.data.mpMax = [stream readInt];
	def.data.mv = [stream readInt];
	def.data.ex = [stream readInt];
	
	// Read items
	int itemCount = [stream readInt];
	for (int i = 0; i < itemCount; i ++) {
		NSNumber *itemId = [NSNumber numberWithInt:[stream readInt]];
		[def.data.itemList addObject:itemId];
	}
	
	// Read magics
	int magicCount = [stream readInt];
	for (int i = 0; i < magicCount; i ++) {
		NSNumber *magicId = [NSNumber numberWithInt:[stream readInt]];
		[def.data.magicList addObject:magicId];
	}
	
	def.data.attackItemIndex = -1;
	def.data.defendItemIndex = -1;
	
	return [def autorelease];
}

/*
-(id) init
{
	self = [super init];
	
	itemList = [[NSMutableArray alloc] init];
	magicList = [[NSMutableArray alloc] init];
	
	return self;
}
*/

-(int) getAnimationId
{
	// For some cases, animationId should be converted
	switch (identifier) {
		case 1016:
			return 16;
		default:
			break;
	}
	
	return identifier;
}

-(int) getId
{
	return identifier;
}

-(NSString *) getRaceString
{
	return [FDLocalString race:race];
}

-(NSString *) getOccupationString
{
	return [FDLocalString occupation:occupation];
}

-(BOOL) canEquip:(int)itemId
{
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:itemId];
	OccupationDefinition *occu = [[DataDepot depot] getOccupationDefinition:occupation];
	
	return (([item isAttackItem] && [occu canUseAttackItem:((AttackItemDefinition *)item).itemCategory])
		 || ([item isDefendItem] && [occu canUseDefendItem:((DefendItemDefinition *)item).itemCategory]));
}

-(void) dealloc
{
	[data release];
	
	[super dealloc];
}

@end
