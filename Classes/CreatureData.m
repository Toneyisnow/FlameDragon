//
//  CreatureData.m
//  FlameDragon
//
//  Created by sui toney on 12-3-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "CreatureData.h"
#import "FDPosition.h"
#import "DataDepot.h"

@implementation CreatureData

@synthesize magicList, itemList;

@synthesize level,ap,dp,dx,hpCurrent,mpCurrent,hpMax,mpMax,mv,ex;
@synthesize attackItemIndex, defendItemIndex;
@synthesize aiType;
@synthesize aiParam;
@synthesize bodyStatus;

-(id) init
{
	self = [super init];
	
	itemList = [[NSMutableArray alloc] init];
	magicList = [[NSMutableArray alloc] init];
	
	attackItemIndex = -1;
	defendItemIndex = -1;
	
	return self;
}

+(int) ITEM_MAX
{
	return 8;
}

+(int) MAGIC_MAX
{
	return 12;
}

-(CreatureData *) clone
{
	CreatureData *another = [[CreatureData alloc] init];
	
	another.level = level;
	another.ap = ap;
	another.dp = dp;
	another.dx = dx;
	another.mv = mv;
	another.ex = ex;
	another.hpCurrent = hpCurrent;
	another.mpCurrent = mpCurrent;
	another.hpMax = hpMax;
	another.mpMax = mpMax;
	
	[another.itemList addObjectsFromArray: itemList];
	[another.magicList addObjectsFromArray: magicList];

	another.attackItemIndex = attackItemIndex;
	another.defendItemIndex = defendItemIndex;
	
	another.bodyStatus = bodyStatus;
	another.aiType = aiType;
	another.aiParam = aiParam;
	
	return [another autorelease];
}

-(void) encodeWithCoder:(NSCoder *)coder {
	
	[coder encodeInt:level forKey:@"level"];
    [coder encodeInt:ap forKey:@"ap"];
    [coder encodeInt:dp forKey:@"dp"];
    [coder encodeInt:dx forKey:@"dx"];
    [coder encodeInt:mv forKey:@"mv"];
    [coder encodeInt:mv forKey:@"ex"];
    [coder encodeInt:hpCurrent forKey:@"hpCurrent"];
    [coder encodeInt:hpMax forKey:@"hpMax"];
    [coder encodeInt:mpCurrent forKey:@"mpCurrent"];
    [coder encodeInt:mpMax forKey:@"mpMax"];
	[coder encodeObject:itemList forKey:@"itemList"];
	[coder encodeObject:magicList forKey:@"magicList"];
	[coder encodeInt:bodyStatus forKey:@"bodyStatus"];
	[coder encodeInt:aiType forKey:@"aiType"];
	[coder encodeCGPoint:[(FDPosition *)aiParam posValue] forKey:@"aiParam"];
	[coder encodeInt:attackItemIndex forKey:@"attackItemIndex"];
    [coder encodeInt:defendItemIndex forKey:@"defendItemIndex"];
    
	// NSLog(@"Encoded CreatureData");

}

-(id) initWithCoder:(NSCoder *)coder {
	
    self = [super init];
	
	level = [coder decodeIntForKey:@"level"];
    ap = [coder decodeIntForKey:@"ap"];
    dp = [coder decodeIntForKey:@"dp"];
    dx = [coder decodeIntForKey:@"dx"];
    mv = [coder decodeIntForKey:@"mv"];
    ex = [coder decodeIntForKey:@"ex"];
    hpCurrent = [coder decodeIntForKey:@"hpCurrent"];
    mpCurrent = [coder decodeIntForKey:@"mpCurrent"];
    hpMax = [coder decodeIntForKey:@"hpMax"];
	mpMax = [coder decodeIntForKey:@"mpMax"];
    bodyStatus = [coder decodeIntForKey:@"bodyStatus"];
    aiType = [coder decodeIntForKey:@"aiType"];
	self.aiParam = [FDPosition position:[coder decodeCGPointForKey:@"aiParam"]];
	itemList = [[coder decodeObjectForKey:@"itemList"] retain];
	magicList = [[coder decodeObjectForKey:@"magicList"] retain];
	attackItemIndex = [coder decodeIntForKey:@"attackItemIndex"];
    defendItemIndex = [coder decodeIntForKey:@"defendItemIndex"];
    
    return self;
}

-(int) hit
{
	int deltaHit = 0;
	AttackItemDefinition *item = [self getAttackItem];
	if (item != nil && [item isAttackItem]) 
	{
		deltaHit = item.hit;
	}
	
	return dx + deltaHit;
}

-(int) hitWithItem:(int)itemId
{
	int deltaHit = 0;
	AttackItemDefinition *item = (AttackItemDefinition *)[[DataDepot depot] getItemDefinition:itemId];
	if (item != nil && [item isAttackItem]) 
	{
		deltaHit = item.hit;
		return dx + deltaHit;
	}
	else {
		return [self hit];
	}	
}

-(int) ev
{
	int deltaEv = 0;
	
	AttackItemDefinition *attackItem = [self getAttackItem];
	if (attackItem != nil && [attackItem isAttackItem]) {
		deltaEv += attackItem.ev;
	}
	
	DefendItemDefinition *defendItem = [self getDefendItem];
	if (defendItem != nil && [defendItem isDefendItem]) {
		deltaEv += defendItem.ev;
	}
	
	return dx + deltaEv;
}

-(int) evWithItem:(int)itemId
{
	int deltaEv = 0;
	
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:itemId];
	AttackItemDefinition *attackItem = [self getAttackItem];
	DefendItemDefinition *defendItem = [self getDefendItem];
	
	if (item != nil) {
		if ([item isAttackItem]) {
			deltaEv = ((AttackItemDefinition *)item).ev;
		}
		if ([item isDefendItem]) {
			deltaEv = ((DefendItemDefinition *)item).ev;
		}
	}
	
	if ((item == nil || ![item isAttackItem]) && attackItem != nil && [attackItem isAttackItem]) {
		deltaEv = attackItem.ev;
	}
	
	if ((item == nil || ![item isDefendItem]) && defendItem != nil && [defendItem isDefendItem]) {
		deltaEv = defendItem.ev;
	}
	
	return dx + deltaEv;	
}

-(int) ap
{
	int deltaAp = 0;
	
	AttackItemDefinition *attackItem = [self getAttackItem];
	if (attackItem != nil && [attackItem isAttackItem]) {
		deltaAp = attackItem.ap;
	}
	
	return ap + deltaAp;
}

-(int) apWithItem:(int)itemId
{
	AttackItemDefinition *item = (AttackItemDefinition *)[[DataDepot depot] getItemDefinition:itemId];
	int deltaAp = 0;
	
	if (item != nil && [item isAttackItem]) {
		deltaAp = item.ap;
		return deltaAp + ap;
	} else {
		return [self ap];
	}
}

-(int) dp
{
	int deltaDp = 0;
	
	DefendItemDefinition *defendItem = [self getDefendItem];
	if (defendItem != nil && [defendItem isDefendItem]) {
		deltaDp = defendItem.dp;
	}
	
	return dp + deltaDp;	
}

-(int) dpWithItem:(int)itemId
{
	DefendItemDefinition *item = (DefendItemDefinition *)[[DataDepot depot] getItemDefinition:itemId];
	int deltaDp = 0;
	
	if (item != nil && [item isDefendItem]) {
		deltaDp = item.dp;
		return dp + deltaDp;	
		
	} else {
		return [self dp];
	}
}

-(AttackItemDefinition *) getAttackItem
{
	if (attackItemIndex >= 0 && attackItemIndex < [itemList count]) {
		int itemId = [[itemList objectAtIndex: attackItemIndex] intValue];
		AttackItemDefinition *def = (AttackItemDefinition *)[[DataDepot depot] getItemDefinition:itemId];
		return def;
	}
	return nil;
}

-(DefendItemDefinition *) getDefendItem
{
	if (defendItemIndex >= 0 && defendItemIndex < [itemList count]) {
		
		int itemId = [[itemList objectAtIndex: defendItemIndex] intValue];
		DefendItemDefinition *def = (DefendItemDefinition *)[[DataDepot depot] getItemDefinition:itemId];
		return def;
	}
	return nil;
}

-(void) removeItem:(int)index
{
	if (index >= 0 && index < [itemList count]) {
		
		[itemList removeObjectAtIndex:index];
		
		if (attackItemIndex == index) {
			attackItemIndex = -1;
		} else if (attackItemIndex > index) {
			attackItemIndex --;
		}
		
		if (defendItemIndex == index) {
			defendItemIndex = -1;
		} else if (defendItemIndex > index) {
			defendItemIndex --;
		}
	}
}

-(void) dealloc
{
	[itemList release];
	[magicList release];
	
	
	[super dealloc];
}

@end
