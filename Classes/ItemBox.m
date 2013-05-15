//
//  ItemBox.m
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "ItemBox.h"
#import "FDSpriteStore.h"
#import "MessageLayer.h"
#import "DataDepot.h"
#import "ItemDefinition.h"
#import "AttackItemDefinition.h"
#import "DefendItemDefinition.h"
#import "UsableItemDefinition.h"
#import "Constants.h"
#import "FDWindow.h"


@implementation ItemBox

@synthesize selectedIndex;

-(id) initWithCreature:(FDCreature *)c Type:(ItemOperatingType)type
{
	self = [super init];
	
	creature = [c retain];
	baseSprite = [[[FDSpriteStore instance] sprite:@"ContainerBase.png"] retain];
	[self initData];
	
	datoBar = [[CreatureDato alloc] initWithAniDef:[[c getDefinition] getAnimationId]];
	detailsBar = [[CreatureDetail alloc] initWithCreature:creature];
	
	operting = type;
	
	selectedIndex = -1;
	indicator = nil;
	
	return self;
}

-(void) initData
{
	for (int i = 0; i < [creature.data.itemList count]; i++) {
		
		int itemId = [[creature.data.itemList objectAtIndex:i] intValue];
		CGPoint location = [self getItemPosition:i];
		
		
		ItemDefinition *def = [[DataDepot depot] getItemDefinition:itemId];
		
		NSString *iconFile = nil;
		int itemInUse = ((creature.data.attackItemIndex == i) || (creature.data.defendItemIndex == i));
		
		// Icon
		/*
		 if ([def isKindOfClass:[AttackItemDefinition class]]) {
			iconFile = [NSString stringWithFormat:@"ItemAttackIcon_%d.png", itemInUse];
		}
		else if ([def isKindOfClass:[DefendItemDefinition class]]) {
			iconFile = [NSString stringWithFormat:@"ItemDefendIcon_%d.png", itemInUse];
		}
		else {
			iconFile = @"ItemUsableIcon_0.png";
		}
		 */
		
		// Icon
		if ([def isAttackItem]) {
		 iconFile = [NSString stringWithFormat:@"ItemAttackIcon_%d.png", itemInUse];
		}
		else if ([def isDefendItem]) {
		 iconFile = [NSString stringWithFormat:@"ItemDefendIcon_%d.png", itemInUse];
		}
		else {
		 iconFile = @"ItemUsableIcon_0.png";
		}
		
		FDSprite *icon = [[FDSpriteStore instance] sprite:iconFile];
		[icon setAnchorPoint:CGPointMake(0, 0)];
		[icon setLocation:CGPointMake(location.x-20, location.y)];
		[baseSprite addSprite:icon zOrder:3];
				
		// Name
		FDSprite *nameSprite = [[FDSprite alloc] initWithString:def.name Size:16];	
		[nameSprite setAnchorPoint:CGPointMake(0, 0)];
		[nameSprite setLocation:CGPointMake(location.x + 10, location.y)];
		[baseSprite addSprite:nameSprite zOrder:3];
		[nameSprite release];
        
		// Attribute
		FDSprite *attSprite = [[FDSprite alloc] initWithString:[def getAttributeString] Size:12];	
		[attSprite setAnchorPoint:CGPointMake(0, 0)];
		[attSprite setLocation:CGPointMake(location.x + 80, location.y)];
		[baseSprite addSprite:attSprite zOrder:3];
		[attSprite release];
		
	}
}

-(void) show:(CCLayer *)l
{
	[super show:l];
	[baseSprite setLocation:[FDWindow showBoxPosition]];
	[baseSprite setScaleX:[Constants battleMapScale] Y:[Constants battleMapScale]];
	
	// Add other Bars
	[datoBar show:l];
	[detailsBar show:l];
}

-(void) close
{
	[datoBar close];
	[detailsBar close];
	
	[super close];
}

-(void) takeTick:(int)synchronizedTick
{
	
	[datoBar takeTick:synchronizedTick];
	[detailsBar takeTick:synchronizedTick];
}

-(void) clickedOn:(CGPoint)location
{
	if (location.y > [FDWindow winSize].height / 2 || operting == ItemOperatingType_ShowOnly) {
		
		// Cancel
		returnValue = [NSNumber numberWithInt:-1];
		[self close];
		
		return;
	}

	CGPoint innerLoc = [self getInnerLocation:location];
	
	int selected = -1;
	for (int i = 0; i < [creature.data.itemList count]; i++) {
		
		CGPoint itemLoc = [self getItemPosition:i];
		if (itemLoc.x < innerLoc.x && itemLoc.y < innerLoc.y
			&& innerLoc.x < itemLoc.x + 150 && innerLoc.y < itemLoc.y + 22) {
			selected = i;
			CCLOG(@"Clicked on item %d", i);
			break;
		}
	}
	
	if (selected >= 0) {
		[self selectItem:selected];
	}
}

// Check whether this item can be selected according to current type
-(void) selectItem:(int)selected
{
	int itemId = [[creature.data.itemList objectAtIndex:selected] intValue];
	
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:itemId];
	
	BOOL canBeUsed = FALSE;
	
	switch (operting) {
		case ItemOperatingType_Use:
			canBeUsed = [item isKindOfClass:[UsableItemDefinition class]];
			break;
		case ItemOperatingType_Equip:
			canBeUsed = [item isKindOfClass:[AttackItemDefinition class]] || [item isKindOfClass:[DefendItemDefinition class]];
			break;
		case ItemOperatingType_Drop:
			canBeUsed = TRUE;
			break;
		case ItemOperatingType_Exchange:
			canBeUsed = TRUE;
			break;
		default:
			break;
	}
	
	if (canBeUsed) {
		
		if (selected == selectedIndex) {
			returnValue = [NSNumber numberWithInt:selected];
			[self close];
		}
		else {
			selectedIndex = selected;
			
			// show indicator
			[self showIndicator:selected];
			
		}
	}
}

-(void) showIndicator:(int)selected
{
	if (indicator == nil) {
		indicator = [[[FDSpriteStore instance] sprite:@"ItemIndicator.png"] retain];
		[baseSprite addSprite:indicator zOrder:1];
	}
	[indicator setAnchorPoint:CGPointMake(0, 0)];
	[indicator setOpacity:50];
	
	[indicator setLocation:[self getItemPosition:selected]];
}

-(CGPoint) getItemPosition:(int)i
{
	int posX = 150*(i / 4) + 25;
	int posY = 73 - 22 * (i % 4);
	
	return CGPointMake(posX, posY);
}

-(void) dealloc
{
	[datoBar release];
	[detailsBar release];
	[creature release];
	[super dealloc];
}

@end
