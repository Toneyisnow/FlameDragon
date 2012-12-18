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
	[self loadOccupationDictionary];
	[self loadSecretSequenceDictionary];
	[self loadLevelUpMagicDictionary];
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
	
	
	// Read base data for enemies
	NSLog(@"Loading Leveled Creature Dictionary.");
	file = [[FDFileStream alloc] initWithDataFile:@"LeveledCreature" Ext:@"dat"];
	[file open];
	
	int baseInfoCount = [file readInt];
	NSMutableDictionary *baseInfoDict = [[NSMutableDictionary alloc] init];
	for (int m = 0; m < baseInfoCount; m++) {
		CreatureDefinition *def = [CreatureDefinition readBaseInfoFromFile:file];
		[baseInfoDict setObject:def forKey:[NSNumber numberWithInt:[def getId]]];
	}
	[file close];
	
	// Read enemy/NPC data
	for (int level = 1; level <= 10; level++) {
		NSString *levelDataFile = [NSString stringWithFormat:@"Chapter-%02d-Creature", level];
		FDFileStream *levelFile = [[FDFileStream alloc] initWithDataFile:levelDataFile Ext:@"dat"];
		[levelFile open];
		
		int leveledCreatureCount = [levelFile readInt];
		for (int m = 0; m < leveledCreatureCount; m++) {
			CreatureDefinition *def = [CreatureDefinition readFromFile:levelFile BaseInfo:baseInfoDict];
			[creatureDictionary setObject:def forKey:[NSNumber numberWithInt:[def getId]]];
		}
		
		[levelFile close];
	}
	
	[baseInfoDict release];
	NSLog(@"Loaded Leveled Creature Dictionary.");
}

-(void) loadOccupationDictionary
{
	NSLog(@"Loading Occupation Dictionary.");
	
	if (occupationDictionary != nil) {
		[occupationDictionary release];
		occupationDictionary = nil;
	}
	
	occupationDictionary = [[NSMutableDictionary alloc] init];
	FDFileStream *file = [[FDFileStream alloc] initWithDataFile:@"Occupation" Ext:@"dat"];
	[file open];
	
	int occupationCount = [file readInt];
	for (int m = 0; m < occupationCount; m++) {
		
		OccupationDefinition *def = [OccupationDefinition readFromFile:file];
		[occupationDictionary setObject:def forKey:[NSNumber numberWithInt:def.occupationId]];
	}
	
	[file close];
	
	NSLog(@"Loaded Occupation Dictionary.");
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
	
	// int shopCount = [file readInt];
	int chapter;
	while ((chapter = [file readInt]) > 0) {
		
		int type = [file readInt];
		int key = chapter * 10 + type;
		
		ShopDefinition *def = [ShopDefinition readFromFile:file];
		[shopDictionary setObject:def forKey:[NSNumber numberWithInt:key]];
	}
	
	[file close];
	
	NSLog(@"Loaded Shop Dictionary.");	
}

-(void) loadSecretSequenceDictionary
{
	NSLog(@"Loading SecretSequence Dictionary.");
	
	if (secretSequenceDictionary != nil) {
		[secretSequenceDictionary release];
		secretSequenceDictionary = nil;
	}
	
	secretSequenceDictionary = [[NSMutableDictionary alloc] init];
	FDFileStream *file = [[FDFileStream alloc] initWithDataFile:@"SecretSequence" Ext:@"dat"];
	[file open];
	
	int chapterCount = [file readInt];
	for (int m = 0; m < chapterCount; m++) {
		
		int chapter = [file readInt];
		SecretSequenceDefinition *def = [SecretSequenceDefinition readFromFile:file];
		[secretSequenceDictionary setObject:def forKey:[NSNumber numberWithInt:chapter]];
	}
	
	[file close];
	
	NSLog(@"Loaded SecretSequence Dictionary.");
}

-(void) loadLevelUpMagicDictionary
{
	NSLog(@"Loading LevelUp Magic Dictionary.");
	
	if (levelUpMagicDictionary != nil) {
		[levelUpMagicDictionary release];
		levelUpMagicDictionary = nil;
	}
	
	levelUpMagicDictionary = [[NSMutableDictionary alloc] init];
	FDFileStream *file = [[FDFileStream alloc] initWithDataFile:@"LevelupMagic" Ext:@"dat"];
	[file open];
	
	LevelUpMagicDefinition * def = [LevelUpMagicDefinition readFromFile:file];
	while (def != nil) {
		[levelUpMagicDictionary setObject:def forKey:[def getKey]];
		def = [LevelUpMagicDefinition readFromFile:file];
	}
	
	[file close];
	
	NSLog(@"Loaded LevelUp Magic Dictionary.");	
}

-(void) loadAnimationDictionary
{
	NSLog(@"Loading Animation Dictionary.");
	
	if (animationDictionary != nil) {
		[animationDictionary release];
		animationDictionary = nil;
	}
	
	animationDictionary  = [[NSMutableDictionary alloc] init];
	
	FDFileStream *file = [[FDFileStream alloc] initWithDataFile:@"FightAnimation"];
	[file open];
	
	int creatureAniId = [file readInt];
	while (creatureAniId > 0) {
	
		// NSLog(@"Load Animation for AniId %d", creatureAniId);
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
		
		creatureAniId = [file readInt];
	}
	
	
	[file close];
	NSLog(@"Loaded Animation Dictionary.");
}


-(ItemDefinition *) getItemDefinition:(int)itemId
{
	ItemDefinition *def = [itemDictionary objectForKey:[NSNumber numberWithInt:itemId]];
	
	if (def == nil) {
		NSLog(@"DataDepot Error: Cannot find ItemId=%d", itemId);
		return nil;
	}
	return def;
}

-(MagicDefinition *) getMagicDefinition:(int)magicId
{
	MagicDefinition *def = [magicDictionary objectForKey:[NSNumber numberWithInt:magicId]];
	
	if (def == nil) {
		NSLog(@"DataDepot Error: Cannot find MagicId=%d", magicId);
		return nil;
	}
	return def;
}

-(CreatureDefinition *) getCreatureDefinition:(int)creatureDefId
{
	CreatureDefinition *def = [creatureDictionary objectForKey:[NSNumber numberWithInt:creatureDefId]];
	
	if (def == nil) {
		NSLog(@"DataDepot Error: Cannot find CreatureDefId=%d", creatureDefId);
		return nil;
	}
	return def;
}

-(LevelUpDefinition *) getLevelUpDefinition:(int)creatureDefId
{
	LevelUpDefinition *def = [levelUpDictionary objectForKey:[NSNumber numberWithInt:creatureDefId]];
	
	if (def == nil) {
		NSLog(@"DataDepot Error: Cannot find LevelUp Information with CreatureDefId=%d", creatureDefId);
		return nil;
	}
	return def;
}

-(ShopDefinition *) getShopDefinition:(int)chapterId Type:(DataDepotShopType)shopType
{
	int key = chapterId * 10 + shopType;
	
	ShopDefinition *def = [shopDictionary objectForKey:[NSNumber numberWithInt:key]];
	
	if (def == nil) {
		NSLog(@"DataDepot Error: Cannot find Shop chapterId=%d shopType=%d", chapterId, shopType);
		return nil;
	}
	return def;
}

-(OccupationDefinition *) getOccupationDefinition:(int)occupationId
{
	OccupationDefinition *def = [occupationDictionary objectForKey:[NSNumber numberWithInt:occupationId]];
	
	if (def == nil) {
		NSLog(@"DataDepot Error: Cannot find OccupationId=%d", occupationId);
		return nil;
	}
	return def;
}

-(SecretSequenceDefinition *) getSecretSequenceDefinition:(int)chapterId
{
	SecretSequenceDefinition *def = [secretSequenceDictionary objectForKey:[NSNumber numberWithInt:chapterId]];
	
	if (def == nil) {
		NSLog(@"DataDepot Error: Cannot find SecretSequence for ChapterId=%d", chapterId);
		return nil;
	}
	return def;
}

-(MagicDefinition *) getLevelUpMagicDefinition:(int)creatureDefId atLeveL:(int)level
{
	int key = creatureDefId * 100 + level;
	LevelUpMagicDefinition *def = [levelUpMagicDictionary objectForKey:[NSNumber numberWithInt:key]];
	
	if (def == nil) {
		return nil;
	}
	
	return [self getMagicDefinition:def.magicId];
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
