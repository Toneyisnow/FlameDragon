//
//  ShoppingShowAmorDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-5-15.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShoppingShowProductDialog.h"
#import "ButtonFactory.h"
#import "DataDepot.h"
#import "FDSpriteStore.h"

@implementation ShoppingShowProductDialog

-(id) initWithList:(NSMutableArray *)list From:(ShoppingDialog *)dia
{
	self = [super init];
	
	startX = 25;
	startY = 55;
	intervalX = 150;
	intervalY = 25;
	
	CGPoint buttonLocation1 = CGPointMake([baseSprite size].width - 120, 20);
	ShoppingButton *button1 = [ButtonFactory createButton:ShoppingButtonType_BuyAmor];
	[button1 setLocation:buttonLocation1];

	//[self addButton:button1];
	
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
		FDSprite *attSprite = [[FDSprite alloc] initWithString:[item getAttributeString] Size:12];	
		[attSprite setAnchorPoint:CGPointMake(0, 0)];
		[attSprite setLocation:CGPointMake(nowX + 80, nowY)];
		[baseSprite addSprite:attSprite zOrder:3];
		
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
			[self onConfirmedExit:returnedObject];

			return;
		}
	}
	
}

-(void) onCancel
{
	[self onConfirmedExit:[NSNumber numberWithInt:-1]];
}

@end
