//
//  Shopping2Dialog.m
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2Dialog.h"
#import "FDSpriteStore.h"
#import "Constants.h"
#import "FDWindow.h"
#import "DataDepot.h"
#import "ShoppingButton.h"
#import "Shopping2Layer.h"

@implementation Shopping2Dialog

-(id) init
{
	self = [super init];
	
	baseSprite = [[FDSpriteStore instance] sprite:@"MessageBox.png"];
	[baseSprite retain];
	
	return self;
}

-(void) show:(CCLayer *)layer
{
	[baseSprite setScaleX:[Constants villageScale] Y:[Constants villageScale]];
	[baseSprite setLocation:[FDWindow downCenter]];
	[super show:layer];
	
	parentLayer = layer;
}

-(void) onExit:(id)returnedObject
{
	NSLog(@"onExit");

	[self close];
	
	// Close dialog
	[(Shopping2Layer *)parentLayer setDialog:nil];
	
	if (selectedCallback != nil) {
		[selectedCallback performSelector:selectedMethod withObject:returnedObject];
	}
}

-(void) setRecord:(ChapterRecord *)r
{
	chapterRecord = r;
}

-(void) setSelectedCallback:(id)obj Method:(SEL)method
{
	selectedCallback = obj;
	selectedMethod = method;
}

-(void) addLabel:(NSString *)str Location:(CGPoint)location
{
	return [self addLabel:str Location:location Size:16];
}

-(void) addLabel:(NSString *)str Location:(CGPoint)location Size:(int)size
{
	if (str == nil) {
		return;
	}
	
	FDSprite *label = [[FDSprite alloc] initWithString:str Size:size];
	[label setLocation:location];
	[label setAnchorPoint:CGPointMake(0, 0)];
	[baseSprite addSprite:label zOrder:1];
}

-(void) clickedOn:(CGPoint)location
{
	if ([self isClicked:location]) {
		[self onClicked:location];
	} else {
		[self onExit:[NSNumber numberWithInt:-1]];
	}
	
	// Fixed: every click should go to onClicked method, to let the child class decide which to return
	//[self onClicked];
}

-(void) clickedViewOn:(id)sender
{
	NSLog(@"Clicked from sender : %@", sender);
	
	CCMenuItem *menu = (CCMenuItem *)sender;
	
	if (menu != NULL && menu.tag >= 0) {
		[self onExit:[NSNumber numberWithInt:menu.tag]];
	}
}

-(BOOL) isClicked:(CGPoint)loc
{
	return loc.y < [FDWindow winSize].height / 2;
}

-(void) onClicked:(CGPoint)location
{
	// This should be override by subclass
}

-(ItemDefinition *) getItemDefinition:(int)shopIndex Type:(int)shopType Index:(int)index
{
	ShopDefinition *shop = [[DataDepot depot] getShopDefinition:shopIndex Type:shopType];
	
	if (index < 0 || index >= [shop.itemList count]) {
		return nil;
	}
	
	NSNumber *itemId = [shop.itemList objectAtIndex:index];
	
	return [[DataDepot depot] getItemDefinition:[itemId intValue]];
}




@end
