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
@synthesize identifier, animationId, race, occupation;

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
	def.animationId = def.identifier % 1000;
	
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
	
	// NSLog(@"Creature %d Loaded.", def.identifier);
	
	return [def autorelease];
}

+(id) readBaseInfoFromFile:(FDFileStream *)stream
{
	CreatureDefinition * def = [[CreatureDefinition alloc] init];
	
	def.identifier = [stream readInt];
	def.animationId = def.identifier % 1000;
	
	def.race = [stream readInt];
	def.occupation = [stream readInt];
	def.data.ap = [stream readInt];
	def.data.dp = [stream readInt];
	def.data.dx = [stream readInt];
	def.data.hpCurrent = def.data.hpMax = [stream readInt];
	def.data.mpCurrent = def.data.mpMax = [stream readInt];
	def.data.mv = [stream readInt];
	def.data.ex = [stream readInt];
	
	return [def autorelease];
}

+(id) readFromFile:(FDFileStream *)stream BaseInfo:(NSMutableDictionary *)dict
{
	if (dict == nil) {
		return nil;
	}
	
	CreatureDefinition * def = [[CreatureDefinition alloc] init];
	
	def.identifier = [stream readInt];
	int baseId = [stream readInt];
	def.data.level = [stream readInt];
	
	CreatureDefinition * baseDef = [dict objectForKey:[NSNumber numberWithInt:baseId]];
	
	if (baseDef == nil) {
		NSLog(@"Error Reading Creature File: Cannot find the base info with Id=%d", baseId);
		return nil;
	}
	
	def.animationId = [baseDef getAnimationId];
	def.name = [FDLocalString creature:baseDef.identifier];
	def.race = baseDef.race;
	def.occupation = baseDef.occupation;
	def.data.ap = baseDef.data.ap * def.data.level;
	def.data.dp = baseDef.data.dp * def.data.level;
	def.data.dx = baseDef.data.dx * def.data.level;
	def.data.hpCurrent = def.data.hpMax = baseDef.data.hpMax * def.data.level;
	def.data.mpCurrent = def.data.mpMax = baseDef.data.mpMax * def.data.level;
	def.data.mv = baseDef.data.mv;
	def.data.ex = baseDef.data.ex;
	
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
	return animationId;
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

-(NSString *) getNameString
{
	return name;
}

-(BOOL) canEquip:(int)itemId
{
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:itemId];
	OccupationDefinition *occu = [[DataDepot depot] getOccupationDefinition:occupation];
	
	return (([item isAttackItem] && [occu canUseAttackItem:((AttackItemDefinition *)item).itemCategory])
		 || ([item isDefendItem] && [occu canUseDefendItem:((DefendItemDefinition *)item).itemCategory]));
}

-(BOOL) isMagicalCreature
{
	return [data.magicList count] > 0;
}

-(BOOL) canFly {
    
    if (occupation == 133 || occupation == 171) {
        return YES;
    }
    
    if (race == 5) {
        return YES;
    }
    
    return NO;
}

-(BOOL) isKnight {
	if (occupation == 131 || occupation == 132) {
		return YES;
	}

	return NO;
}

-(int) getMaximumLevel {
    
    if (race == 7) {
        return 99;
    }
    
    return 40;
}

-(void) dealloc
{
	[data release];
	
	[super dealloc];
}

@end
