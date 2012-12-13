//
//  LevelUpDefinition.m
//  FlameDragon
//
//  Created by sui toney on 12-1-19.
//  Copyright 2012 ms. All rights reserved.
//

#import "LevelUpDefinition.h"
#import "FDFileStream.h"

@implementation LevelUpDefinition

@synthesize identifier;
@synthesize hpRange, mpRange, apRange, dpRange, dxRange;

+(id) readFromFile:(FDFileStream *)stream
{
	LevelUpDefinition * def = [[LevelUpDefinition alloc] init];
	
	def.identifier = [stream readInt];
	
	
	def.hpRange = [stream readRange];
	def.mpRange = [stream readRange];
	def.apRange = [stream readRange];
	def.dpRange = [stream readRange];
	def.dxRange = [stream readRange];
	
	return [def autorelease];
}

-(int) getId
{
	return identifier;
}

@end
