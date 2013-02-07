//
//  TransferDefinition.m
//  FlameDragon
//
//  Created by sui toney on 13-2-6.
//  Copyright 2013 ms. All rights reserved.
//

#import "TransferDefinition.h"


@implementation TransferDefinition

@synthesize apRange, dpRange, dxRange, hpRange, mpRange, mvRange;
@synthesize transferId, fromCreatureDefId, toCreatureDefId, requireItemId;

+(id) readFromFile:(FDFileStream *)stream
{
	TransferDefinition * def = [[TransferDefinition alloc] init];
	
	def.transferId = [stream readInt];
	// def.fromCreatureDefId = [stream readInt];
	def.toCreatureDefId = def.transferId;
	
	def.apRange = [stream readRange];
	def.dpRange = [stream readRange];
	def.dxRange = [stream readRange];
	def.hpRange = [stream readRange];
	def.mpRange = [stream readRange];
	def.mvRange = [stream readRange];
	
	return def;
}

@end
