//
//  Shopping2ShowFriendsDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ShowFriendsDialog.h"
#import "DataDepot.h"
#import "SWScrollView.h"
#import "CreatureRecord.h"
#import "FDLocalString.h"

@implementation Shopping2ShowFriendsDialog


// Deprecated Function
-(id) initWithFriends:(NSMutableArray *)list
{
	self = [super init];
	
	//[self addLabel:@"List All Friends ..." Location:[FDWindow shoppingMessageLocation]];
	int screenHeight = 120;
	int intervalX = 120;
	int intervalY = 30;
	int viewLength = [list count] > 6 ? ([list count] + 1)/2 * intervalY : screenHeight;
	int startX = 10;
	int startY = viewLength - 2 * intervalY + 5;
	
	
	SWScrollView *view = [SWScrollView viewWithViewSize: CGSizeMake(400, screenHeight)];
	view.position = ccp(10, 20);
	view.contentOffset = ccp(0, screenHeight - viewLength - intervalY);
	view.direction = SWScrollViewDirectionVertical;
	view.clipsToBounds = YES;
	//[view setClickedCallback:(id)obj Method:@selector(clickedViewOn:)];
	
	for (int i = 0; i < [list count]; i++)
	{
		CreatureRecord *record = [list objectAtIndex:i];
		int definitionId = record.definitionId;
		
		//CCSprite *icon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"Icon-%03d-02.png", definitionId]];
		NSString *creatureName = [FDLocalString creature:definitionId];
		
		FDSprite *nameSprite = [[FDSprite alloc] initWithString:creatureName Size:14];
				
		CCMenuItem *iconMenuItem = [CCMenuItemImage 
									itemFromNormalImage:[NSString stringWithFormat:@"Icon-%03d-02.png", definitionId] selectedImage:NULL
									target:self selector:@selector(clickedViewOn:)];
		iconMenuItem.position = ccp(startX + intervalX * (i % 2), startY - intervalY * (i / 2));
		iconMenuItem.tag = definitionId;
		iconMenuItem.anchorPoint = ccp(0, 0);		
		
		CCMenuItemSprite* nameMenuItem = [CCMenuItemSprite itemFromNormalSprite:[nameSprite getSprite] selectedSprite:NULL target:self selector:@selector(clickedViewOn:)];
		
		nameMenuItem.position = ccp(startX + intervalX * (i % 2) + 25, startY - intervalY * (i / 2));
		nameMenuItem.tag = i;
		nameMenuItem.anchorPoint = ccp(0, 0);
		
		CCMenu *menu = [CCMenu menuWithItems:iconMenuItem, nameMenuItem, nil];
		menu.position = CGPointZero;
		[view addChild:menu];

		[nameSprite release];
	}
	
	view.contentSize = CGSizeMake(400, viewLength + intervalY);
	
	[[baseSprite getSprite] addChild:view];
	
	return self;
}

-(id) initWithFriends:(NSMutableArray *)list pageIndex:(int)pIndex
{
	self = [super initWithList:list pageIndex:pIndex];
	
	return self;
}

-(void) initComponents
{
	int startX = 10;
	int startY = 50;
	int intervalX = 100;
	int intervalY = 28;
	
	int max_item_count = [self getMaxItemCount];
	int startIndex = pageIndex * max_item_count;
	
	for (int i = 0; i + startIndex < [itemList count] && i < max_item_count; i++)
	{
		CreatureRecord *record = [itemList objectAtIndex:(i + startIndex)];
		
		//CCSprite *icon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"Icon-%03d-02.png", definitionId]];
		NSString *creatureName = [FDLocalString creature:record.definitionId];
		
		FDSprite *nameSprite = [[FDSprite alloc] initWithString:creatureName Size:14];
		
		CCMenuItem *iconMenuItem = [CCMenuItemImage 
									itemFromNormalImage:[NSString stringWithFormat:@"Icon-%03d-02.png", record.definitionId] selectedImage:NULL
									target:self selector:@selector(clickedViewOn:)];
		iconMenuItem.position = ccp(startX + intervalX * (i % 3), startY - intervalY * (i / 3));
		iconMenuItem.tag = record.definitionId;
		iconMenuItem.anchorPoint = ccp(0, 0);		
		
		CCMenuItemSprite* nameMenuItem = [CCMenuItemSprite itemFromNormalSprite:[nameSprite getSprite] selectedSprite:NULL target:self selector:@selector(clickedViewOn:)];
		
		nameMenuItem.position = ccp(startX + intervalX * (i % 3) + 25, startY - intervalY * (i / 3));
		nameMenuItem.tag = i;
		nameMenuItem.anchorPoint = ccp(0, 0);
		
		CCMenu *menu = [CCMenu menuWithItems:iconMenuItem, nameMenuItem, nil];
		menu.position = CGPointZero;
		[[baseSprite getSprite] addChild:menu];
		
		[nameSprite release];
	}
	
}

-(int) getMaxItemCount
{
	return 6;
}

-(void) clickedViewOn:(id)sender
{
	NSLog(@"Clicked from sender : %@", sender);
	
	CCMenuItem *menu = (CCMenuItem *)sender;
	
	if (menu != NULL && menu.tag >= 0) {
		[self onExit:[NSNumber numberWithInt:menu.tag]];
	}
}

-(void) onClicked:(CGPoint)location
{
	/*
	 Do nothing
	 
	int selected = 0;
	
	NSLog(@"Select Friend Index %d", selected);	
	id returnedObject = [NSNumber numberWithInt:selected];
	[self onExit:returnedObject];
	 
	 */
}


@end
