//
//  ShoppingDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShoppingDialog.h"
#import "FDSpriteStore.h"
#import "Constants.h"
#import "FDWindow.h"
#import "DataDepot.h"

@implementation ShoppingDialog

@synthesize responder;
@synthesize pushCallback, exitCallback;

-(id) init
{
	self = [super init];
	
	baseSprite = [[FDSpriteStore instance] sprite:@"MessageBox.png"];
	[baseSprite retain];

	buttonArray = [[NSMutableArray alloc] init];
	
	return self;
}

-(id) initFrom:(ShoppingDialog *)origin
{
	self = [self init];
	
	[self setCallback:origin.responder PushMethod:origin.pushCallback ExitMethod:origin.exitCallback];
	
	return self;
}

-(void) show:(CCLayer *)layer
{
	[baseSprite setScaleX:[Constants villageScale] Y:[Constants villageScale]];
	[baseSprite setLocation:[FDWindow downCenter]];
	[super show:layer];
}

-(void) onExit
{
	NSLog(@"onExit");
	if (responder != nil) {
		[responder performSelector:exitCallback];
	}
}

-(void) onCancel
{
	NSLog(@"onCancel");
	
	[self onExit];
}

-(void) onConfirmedExit:(id)returnedObject
{
	NSLog(@"onConfirmedExit");
	
	[self onExit];
	if (selectedCallback != nil) {
		[selectedCallback performSelector:selectedMethod withObject:returnedObject];
	}
}

-(void) onPush:(ShoppingDialog *)dialog
{
	if (responder != nil) {
		[responder performSelector:pushCallback withObject:dialog];
	}
}

-(void) setRecord:(ChapterRecord *)r
{
	chapterRecord = r;
}

-(void) setCallback:(id)obj PushMethod:(SEL)pm ExitMethod:(SEL)em
{
	responder = obj;
	pushCallback = pm;
	exitCallback = em;
}

-(void) setSelectedCallback:(id)obj Method:(SEL)method
{
	selectedCallback = obj;
	selectedMethod = method;
}

/*
-(void) setExitCallback:(id)obj Method:(SEL)m
{
	responder = obj;
	exitCallback = m;
}
*/

-(void) addButton:(ShoppingButton *)button
{
	if (button == nil) {
		return;
	}
	
	[baseSprite addSprite:[button getSprite] zOrder:0];
	[buttonArray addObject:button];
}

-(void) addLabel:(NSString *)str Location:(CGPoint)location
{
	if (str == nil) {
		return;
	}
	
	FDSprite *label = [[FDSprite alloc] initWithString:str Size:16];
	[label setLocation:location];
	[baseSprite addSprite:label zOrder:1];
    [label release];
}

-(void) clickedOn:(CGPoint)location
{
	CGPoint innnerLocation = [self getInnerLocation:location];
	
	for (ShoppingButton *button in buttonArray) {
		if ([button isClicked:innnerLocation]) {
			[button onClick];
			return;
		}
	}
	
	
	if ([self isClicked:location]) {
		[self onClicked:location];
	} else {
		[self onCancel];
	}
	
	// Fixed: every click should go to onClicked method, to let the child class decide which to return
	//[self onClicked];
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
	NSNumber *itemId = [shop.itemList objectAtIndex:index];
	
	return [[DataDepot depot] getItemDefinition:[itemId intValue]];
}

/*
-(NSMutableArray *) getProductList:(int)shopIndex Type:(int)shopType
{
	ShopDefinition *shop = [[DataDepot depot] getShopDefinition:shopType Chapter:shopIndex];
	return shop.itemList;
}
*/

-(void) dealloc
{
	[buttonArray release];
	
	[super dealloc];
}



@end
