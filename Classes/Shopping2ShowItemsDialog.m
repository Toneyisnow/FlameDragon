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
	self = [super initWithList:iList pageIndex:pIndex];
	
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
		
		FDSprite *icon = [[FDSpriteStore instance] sprite:iconFile];
		[icon setAnchorPoint:CGPointMake(0, 0)];
		[icon setLocation:CGPointMake(nowX - 20, nowY)];
		[baseSprite addSprite:icon zOrder:3];
		
		// Name
		FDSprite *nameSprite = [[FDSprite alloc] initWithString:item.name Size:16];	
		[nameSprite setAnchorPoint:CGPointMake(0, 0)];
		[nameSprite setLocation:CGPointMake(nowX + 10, nowY)];
		[baseSprite addSprite:nameSprite zOrder:3];
		
		// Attribute
		FDSprite *attSprite = [[FDSprite alloc] initWithString:[item getAttributeString] Size:9];	
		[attSprite setAnchorPoint:CGPointMake(0, 0)];
		[attSprite setLocation:CGPointMake(nowX + 80, nowY + 10)];
		[baseSprite addSprite:attSprite zOrder:3];
		
		// Money
		NSString *moneyStr = [NSString stringWithFormat:@"$ %05d", item.price];
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

-(void) onClicked:(CGPoint)location
{
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
}

@end
