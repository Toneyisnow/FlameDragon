//
//  Shopping2ShowItemsDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ShowItemsDialog.h"
#import "ItemDefinition.h"
#import "FDSpriteStore.h"
#import "DataDepot.h"

@implementation Shopping2ShowItemsDialog

-(id) initWithItemList:(NSMutableArray *)iList pageIndex:(int)pIndex
{
	self = [super init];
	[super initializeWithList:iList pageIndex:pIndex];
	return self;
}

-(void) initComponents
{
	startX = 25;
	startY = 55;
	intervalX = 150;
	intervalY = 25;
	
	int max_item_count = [self getMaxItemCount];
	int startIndex = pageIndex * max_item_count;
	
	for (int i = 0; i + startIndex < [itemList count] && i < max_item_count; i++)
	{
		int nowX = startX + intervalX * (i % 2);
		int nowY = startY - intervalY * (i / 2);
		//CGPoint itemLocation = CGPointMake(nowX, nowY);
		
		int itemId = [[itemList objectAtIndex:(i+startIndex)] intValue];
		ItemDefinition *item = [[DataDepot depot] getItemDefinition:itemId];
		
		NSString *iconFile = nil;
		if ([item isAttackItem]) {
			iconFile = @"ItemAttackIcon_0.png";
		}
		else if ([item isDefendItem]) {
			iconFile = @"ItemDefendIcon_0.png";
		}
		else {
			iconFile = @"ItemUsableIcon_0.png";
		}
		
		// Icon
		CCMenuItem *iconMenuItem = [CCMenuItemImage 
									itemFromNormalImage:iconFile selectedImage:NULL
									target:self selector:@selector(clickedViewOn:)];
		iconMenuItem.position = ccp(nowX - 20, nowY);
		iconMenuItem.tag = i + startIndex;
		iconMenuItem.anchorPoint = ccp(0, 0);		
		
		// Name
		FDSprite *nameSprite = [[FDSprite alloc] initWithString:item.name Size:16];	
		CCMenuItemSprite* nameMenuItem = [CCMenuItemSprite itemFromNormalSprite:[nameSprite getSprite] selectedSprite:NULL target:self selector:@selector(clickedViewOn:)];
		nameMenuItem.position = ccp(nowX + 10, nowY);
		nameMenuItem.tag = i + startIndex;
		nameMenuItem.anchorPoint = ccp(0, 0);
		
		CCMenu *menu = [CCMenu menuWithItems:iconMenuItem, nameMenuItem, nil];
		menu.position = CGPointZero;
		[[baseSprite getSprite] addChild:menu];
		
		[nameSprite release];

		// Attribute
		FDSprite *attSprite = [[FDSprite alloc] initWithString:[item getAttributeString] Size:9];	
		[attSprite setAnchorPoint:CGPointMake(0, 0)];
		[attSprite setLocation:CGPointMake(nowX + 80, nowY + 10)];
		[baseSprite addSprite:attSprite zOrder:3];
		
		// Money
		NSString *moneyStr = [NSString stringWithFormat:@"$ %05d", [self getPrice:item]];
		FDSprite *moneySprite = [[FDSprite alloc] initWithString:moneyStr Size:9];	
		[moneySprite setAnchorPoint:CGPointMake(0, 0)];
		[moneySprite setLocation:CGPointMake(nowX + 80, nowY)];
		[baseSprite addSprite:moneySprite zOrder:3];
	}
}

-(int) getMaxItemCount
{
	return 6;
}

-(int) getPrice:(ItemDefinition *)item
{
	return item.price;
}

-(void) onClicked:(CGPoint)location
{
	// Do nothing
	/*
	CGPoint innnerLocation = [self getInnerLocation:location];

	int max_item_count = [self getMaxItemCount];
	int startIndex = pageIndex * max_item_count;
	for (int i = 0; i + startIndex < [itemList count] && i < max_item_count; i++)
	{
		int nowX = startX + intervalX * (i % 2);
		int nowY = startY - intervalY * (i / 2);
		
		if (innnerLocation.x > nowX - 20 && innnerLocation.x < nowX + 80
			&& innnerLocation.y > nowY - 10 && innnerLocation.y < nowY + 10) {
			
			NSLog(@"Select Product Item Index: %d", i + startIndex);	
			id returnedObject = [NSNumber numberWithInt:(i + startIndex)];
			[self onExit:returnedObject];
			
			return;
		}
	}
	 */
}

@end
