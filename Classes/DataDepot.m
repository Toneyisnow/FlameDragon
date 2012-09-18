//
//  DataDepot.m
//  FlameDragon
//
//  Created by sui toney on 11-11-23.
//  Copyright 2011 ms. All rights reserved.
//

#import "DataDepot.h"
#import "UsableItemDefinition.h"
#import "AttackItemDefinition.h"
#import "DefendItemDefinition.h"
#import "MoneyItemDefinition.h"
#import "SpecialItemDefinition.h"

static DataDepot *instance = nil;

@implementation DataDepot


+(DataDepot *) depot
{
	@synchronized(self)
	{
		if(instance == nil)
		{
			instance = [[DataDepot alloc] init];
		}
	}
	return instance;
}


-(void) loadAllDictionaries
{
	[self loadItemDictionary];
	[self loadMagicDictionary];
	[self loadCreatureDictionary];
	[self loadAnimationDictionary];
	[self loadLevelUpDictionary];
	[self loadShopDictionary];
}

-(void) loadItemDictionary
{
	NSLog(@"Loading Item Dictionary.");
	
	if (itemDictionary != nil) {
		[itemDictionary release];
		itemDictionary = nil;
	}
	
	itemDictionary = [[NSMutableDictionary alloc] init];
	FDFileStream *file = [[FDFileStream alloc] initWithDataFile:@"Item" Ext:@"dat"];
	[file open];
	
	int usableCount = [file readInt];
	for (int m = 0; m < usableCount; m++) {
		
		UsableItemDefinition *def = [UsableItemDefinition readFromFile:file];
		[itemDictionary setObject:def forKey:[NSNumber numberWithInt:def.identifier]];
	}
	
	int attackCount = [file readInt];
	for (int m = 0; m < attackCount; m++) {
		
		AttackItemDefinition *def = [AttackItemDefinition readFromFile:file];
		[itemDictionary setObject:def forKey:[NSNumber numberWithInt:def.identifier]];
	}
	
	int defendCount = [file readInt];
	for (int m = 0; m < defendCount; m++) {
		
		DefendItemDefinition *def = [DefendItemDefinition readFromFile:file];
		[itemDictionary setObject:def forKey:[NSNumber numberWithInt:def.identifier]];
	}
		
	int specialCount = [file readInt];
	for (int m = 0; m < specialCount; m++) {
		
		SpecialItemDefinition *def = [SpecialItemDefinition readFromFile:file];
		[itemDictionary setObject:def forKey:[NSNumber numberWithInt:def.identifier]];
	}
	
	int moneyCount = [file readInt];
	for (int m = 0; m < moneyCount; m++) {
		
		MoneyItemDefinition *def = [MoneyItemDefinition readFromFile:file];
		[itemDictionary setObject:def forKey:[NSNumber numberWithInt:def.identifier]];
	}
	
	[file close];
	NSLog(@"Loaded Item Dictionary.");
}

-(void) loadMagicDictionary
{
	NSLog(@"Loading Magic Dictionary.");
	
	if (magicDictionary != nil) {
		[magicDictionary release];
		magicDictionary = nil;
	}

	magicDictionary = [[NSMutableDictionary alloc] init];
	FDFileStream *file = [[FDFileStream alloc] initWithDataFile:@"Magic" Ext:@"dat"];
	[file open];
	
	int magicCount = [file readInt];
	for (int m = 0; m < magicCount; m++) {
		
		MagicDefinition *def = [MagicDefinition readFromFile:file];
		[magicDictionary setObject:def forKey:[NSNumber numberWithInt:def.identifier]];
	}
	
	[file close];
	NSLog(@"Loaded Magic Dictionary.");	
}

-(void) loadCreatureDictionary
{
	NSLog(@"Loading Creature Dictionary.");
	
	if (creatureDictionary != nil) {
		[creatureDictionary release];
		creatureDictionary = nil;
	}
	
	creatureDictionary = [[NSMutableDictionary alloc] init];
	FDFileStream *file = [[FDFileStream alloc] initWithDataFile:@"Creature" Ext:@"dat"];
	[file open];
	
	int creatureCount = [file readInt];
	for (int m = 0; m < creatureCount; m++) {
		
		CreatureDefinition *def = [CreatureDefinition readFromFile:file];
		[creatureDictionary setObject:def forKey:[NSNumber numberWithInt:[def getId]]];
	}
		
	[file close];
	NSLog(@"Loaded Creature Dictionary.");
	
}

-(void) loadLevelUpDictionary
{
	NSLog(@"Loading LevelUp Dictionary.");
	
	if (levelUpDictionary != nil) {
		[levelUpDictionary release];
		levelUpDictionary = nil;
	}
	
	levelUpDictionary = [[NSMutableDictionary alloc] init];
	FDFileStream *file = [[FDFileStream alloc] initWithDataFile:@"Levelup" Ext:@"dat"];
	[file open];
	
	int levelupCount = [file readInt];
	for (int m = 0; m < levelupCount; m++) {
		
		LevelUpDefinition *def = [LevelUpDefinition readFromFile:file];
		[levelUpDictionary setObject:def forKey:[NSNumber numberWithInt:[def getId]]];
	}
	
	[file close];
	
	NSLog(@"Loaded LevelUp Dictionary.");
}

-(void) loadShopDictionary
{
	NSLog(@"Loading Shop Dictionary.");

	
	if (shopDictionary != nil) {
		[shopDictionary release];
		shopDictionary = nil;
	}
	
	shopDictionary = [[NSMutableDictionary alloc] init];
	FDFileStream *file = [[FDFileStream alloc] initWithDataFile:@"Shop" Ext:@"dat"];
	[file open];
	
	int shopCount = [file readInt];
	for (int m = 0; m < shopCount; m++) {
		
		int chapter = [file readInt];
		int type = [file readInt];
		int key = chapter * 10 + type;
		
		ShopDefinition *def = [ShopDefinition readFromFile:file];
		[shopDictionary setObject:def forKey:[NSNumber numberWithInt:key]];
	}
	
	[file close];
	
	NSLog(@"Loaded Shop Dictionary.");	
}

-(void) loadAnimationDictionary
{
	NSLog(@"Loading Animation Dictionary.");
	
	if (animationDictionary != nil) {
		[animationDictionary release];
		animationDictionary = nil;
	}
	
	animationDictionary  = [[NSMutableDictionary alloc] init];
	
	FDFileStream *file = [[FDFileStream alloc] initWithDataFile:@"Animation"];
	[file open];
	
	int creatureCount = [file readInt];
	for (int k = 0;  k < creatureCount; k++) {
		int creatureAniId = [file readInt];
		int aniCount = [file readInt];
		
		// Idle Animation
		AnimationDefinition *idleAni = [AnimationDefinition readFightAnimationFromFile:file CreatureAniId:creatureAniId Type:AnimationType_FightIdle];
		[animationDictionary setObject:idleAni forKey:[NSString stringWithFormat:@"%d-%d", creatureAniId, AnimationType_FightIdle]];
										
		// Attack Animation
		AnimationDefinition *attackAni = [AnimationDefinition readFightAnimationFromFile:file CreatureAniId:creatureAniId Type:AnimationType_FightAttack];
		[animationDictionary setObject:attackAni forKey:[NSString stringWithFormat:@"%d-%d", creatureAniId, AnimationType_FightAttack]];
		
		// Skill Animation
		if (aniCount > 2) {
			AnimationDefinition *skillAni = [AnimationDefinition readFightAnimationFromFile:file CreatureAniId:creatureAniId Type:AnimationType_FightSkill];
			[animationDictionary setObject:skillAni forKey:[NSString stringWithFormat:@"%d-%d", creatureAniId, AnimationType_FightSkill]];
		}
		else {
			[animationDictionary setObject:attackAni forKey:[NSString stringWithFormat:@"%d-%d", creatureAniId, AnimationType_FightSkill]];
			
		}
	}
	
	
	[file close];
	NSLog(@"Loaded Animation Dictionary.");
}


-(ItemDefinition *) getItemDefinition:(int)itemId
{
	return [itemDictionary objectForKey:[NSNumber numberWithInt:itemId]];
}

-(MagicDefinition *) getMagicDefinition:(int)magicId
{
	return [magicDictionary objectForKey:[NSNumber numberWithInt:magicId]];
}

-(CreatureDefinition *) getCreatureDefinition:(int)creatureDefId
{
	return [creatureDictionary objectForKey:[NSNumber numberWithInt:creatureDefId]];
}

-(LevelUpDefinition *) getLevelUpDefinition:(int)creatureDefId
{
	return [levelUpDictionary objectForKey:[NSNumber numberWithInt:creatureDefId]];
}

-(ShopDefinition *) getShopDefinition:(int)chapterId Type:(DataDepotShopType)shopType
{
	int key = chapterId * 10 + shopType;
	
	return [shopDictionary objectForKey:[NSNumber numberWithInt:key]];
}

-(AnimationDefinition *) getAnimationDefinition:(AnimationType)type Id:(int)aniId
{
	NSString *key = [NSString stringWithFormat:@"%d-%d",aniId, type];
	
	if ([animationDictionary objectForKey:key] == nil) {
		
		AnimationDefinition *def = [AnimationDefinition animationWithType:type Id:aniId];
		if (def == nil) {
			return nil;
		}
		
		[animationDictionary setObject:def forKey:key];
	}
	
	
	return [animationDictionary objectForKey:key];
}

@end
