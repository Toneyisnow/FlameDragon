//
//  FDTreasure.m
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDTreasure.h"
#import "FDSpriteStore.h"
#import "DataDepot.h"

@implementation FDTreasure

+(id) treasureWithType:(TreasureType)t Item:(int)i
{
	FDTreasure *treasure = [[self alloc] initWithType:t Item:i];
	return [treasure autorelease];
}

-(id) initWithType:(TreasureType)t Item:(int)i
{
	self = [super init];
	
	[self setSprite:[[FDSpriteStore instance] sprite:@"Empty.png"]];
	
	hasOpened = FALSE;
	zOrder = BattleObjectOrder_OnGround;
	
	type = t;
	itemId = i;
	
	return self;
}

-(BOOL) hasOpened
{
	return hasOpened;
}

-(void) setOpened
{
	hasOpened = TRUE;
	
	FDImage *image;
	switch (type) {
		case TreasureType_Red:
			image = [[FDSpriteStore instance] image:@"BoxOpened_Red.png"];
			[sprite setImage:image];
			break;
		case TreasureType_Blue:
			image = [[FDSpriteStore instance] image:@"BoxOpened_Blue.png"];
			[sprite setImage:image];
			break;
		default:
			break;
	}
}

-(TreasureType) treasureType
{
	return type;
}

-(int) itemId
{
	return itemId;
}

-(ItemDefinition *) getItem
{
	return [[DataDepot depot] getItemDefinition:itemId];
}

-(void) changeItemId:(int)it
{
	itemId = it;
}

@end
