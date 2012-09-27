//
//  Shopping2PagedDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-22.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2PagedDialog.h"


@implementation Shopping2PagedDialog



-(void) initializeWithList:(NSMutableArray *)iList pageIndex:(int)pIndex
{
	NSLog(@"Paged Dialog inited. %d, %d", [iList count], pIndex);
	
	pageIndex = pIndex;
	itemList = [iList retain];

	int max_item_count = [self getMaxItemCount];
	NSLog(@"Item Count: %d", [itemList count]);

	int startIndex = pageIndex * max_item_count;

	[self initComponents];
	
	CCMenu *menu;
	if (pageIndex > 0) {
		
		FDSprite *upSprite = [[FDSprite alloc] initWithString:@"A" Size:14];
		CCMenuItemSprite* upMenu = [CCMenuItemSprite itemFromNormalSprite:[upSprite getSprite] selectedSprite:NULL target:self selector:@selector(clickedUp)];
		
		upMenu.position = ccp(290, 65);
		upMenu.anchorPoint = ccp(0, 0);
		
		menu = [CCMenu menuWithItems:upMenu, nil];
		menu.position = CGPointZero;
		[[baseSprite getSprite] addChild:menu];
	}
	
	if (startIndex + max_item_count < [[self getShownList] count] ) {
		
		FDSprite *downSprite = [[FDSprite alloc] initWithString:@"V" Size:14];
		CCMenuItemSprite* downMenu = [CCMenuItemSprite itemFromNormalSprite:[downSprite getSprite] selectedSprite:NULL target:self selector:@selector(clickedDown)];
		
		downMenu.position = ccp(290, 10);
		downMenu.anchorPoint = ccp(0, 0);
		
		menu = [CCMenu menuWithItems:downMenu, nil];
		menu.position = CGPointZero;
		[[baseSprite getSprite] addChild:menu];
	}
}

-(void) initComponents
{
}

-(NSMutableArray *) getShownList
{
	return itemList;
}

-(int) getMaxItemCount
{
	// Each subclass should implement this
	return 1;
}

-(void) clickedUp
{
	[self onExit:[NSNumber numberWithInt:-2]];
}

-(void) clickedDown
{
	[self onExit:[NSNumber numberWithInt:-3]];
}



@end
