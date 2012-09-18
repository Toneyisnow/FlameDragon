//
//  ButtonFactory.m
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "ButtonFactory.h"
#import "FDSpriteStore.h"

@implementation ButtonFactory


+(ShoppingButton *) createButton:(ShoppingButtonType)type
{
	ShoppingButton *button;
	
	switch (type) {
		case ShoppingButtonType_BuyAmor:
			
			button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"ItemAttackIcon_0.png"]];
			break;
		case ShoppingButtonType_BuyItem:
			button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"ItemAttackIcon_0.png"]];
			break;
		case ShoppingButtonType_Sell:
			button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"ItemAttackIcon_0.png"]];
			break;
		case ShoppingButtonType_Exchange:
			button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"ItemAttackIcon_0.png"]];
			break;
		case ShoppingButtonType_Info:
			button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"ItemAttackIcon_0.png"]];
			break;
		case ShoppingButtonType_Save:
			button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"ItemAttackIcon_0.png"]];
			break;
		case ShoppingButtonType_Load:
			button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"ItemAttackIcon_0.png"]];
			break;
		case ShoppingButtonType_Transfer:
			button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"ItemAttackIcon_0.png"]];
			break;
		case ShoppingButtonType_Revive:
			button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"ItemAttackIcon_0.png"]];
			break;
		case ShoppingButtonType_Exit:
			button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"ItemAttackIcon_0.png"]];
			break;
		default:
			break;
	}
	
	return [button autorelease];
}

@end
