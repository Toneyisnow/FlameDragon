//
//  LevelUpMagicDefinition.m
//  FlameDragon
//
//  Created by sui toney on 12-12-13.
//  Copyright 2012 ms. All rights reserved.
//

#import "LevelUpMagicDefinition.h"


@implementation LevelUpMagicDefinition

@synthesize creatureDefId, creatureLevel, magicId;

+(id) readFromFile:(FDFileStream *)stream
{
	int defId = [stream readInt];
	
	if (defId < 0) {
		return nil;
	}
	
	LevelUpMagicDefinition * def = [[LevelUpMagicDefinition alloc] init];
	
	def.creatureDefId = defId;
	def.creatureLevel = [stream readInt];
	def.magicId = [stream readInt];
	
	return [def autorelease];
}

-(NSNumber *) getKey
{
	return [NSNumber numberWithInt:creatureDefId * 100 + creatureLevel];
}


@end
