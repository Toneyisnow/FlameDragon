//
//  Shopping2ShowAmorDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-5-15.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ShowProductDialog.h"
#import "ButtonFactory.h"
#import "DataDepot.h"
#import "FDSpriteStore.h"

@implementation Shopping2ShowProductDialog

-(id) initWithList:(NSMutableArray *)list
{
	self = [super init];
	
	startX = 25;
	startY = 55;
	intervalX = 150;
	intervalY = 25;
	
	itemCount = [list count];
	NSLog(@"Product Count: %d", itemCount);
	
	for(int i = 0; i < itemCount; i++)
	{
		int nowX = startX + intervalX * (i % 2);
		int nowY = startY - intervalY * (i / 2);
		//CGPoint itemLocation = CGPointMake(nowX, nowY);
		
		int itemId = [[list objectAtIndex:i] intValue];
		
		ItemDefinition *item = [[DataDepot depot] getItemDefinition:itemId];
		
		NSString *iconFile = nil;
		if ([item isAttackItem]) {
			iconFile = [NSString stringWithFormat:@"ItemAttackIcon_%d.png", FALSE];
		}
		else if ([item isDefendItem]) {
			iconFile = [NSString stringWithFormat:@"ItemDefendIcon_%d.png", FALSE];
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
	
	return self;
}

-(void) onClicked:(CGPoint)location
{
	CGPoint innnerLocation = [self getInnerLocation:location];
	
	for(int i = 0; i < itemCount; i++)
	{
		int nowX = startX + intervalX * (i % 2);
		int nowY = startY - intervalY * (i / 2);
		
		if (innnerLocation.x > nowX - 20 && innnerLocation.x < nowX + 80
			&& innnerLocation.y > nowY - 10 && innnerLocation.y < nowY + 10) {
			
			NSLog(@"Select Product Item Index: %d", i);	
			id returnedObject = [NSNumber numberWithInt:i];
			[self onExit:returnedObject];
			
			return;
		}
	}
}


@end
