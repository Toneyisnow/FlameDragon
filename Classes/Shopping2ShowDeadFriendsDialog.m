//
//  Shopping2ShowDeadFriendsDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-13.
//  Copyright 2012 ms. All rights reserved.
//


#import "Shopping2ShowDeadFriendsDialog.h"
#import "CreatureRecord.h"
#import "FDLocalString.h"

@implementation Shopping2ShowDeadFriendsDialog


-(id) initWithFriends:(NSMutableArray *)list pageIndex:(int)pIndex
{
	self = [super init];	
	[super initializeWithList:list pageIndex:pIndex];
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
	
	deadFriends = [[NSMutableArray alloc] init];
	for (int i = 0; i < [itemList count]; i++) {
		CreatureRecord *record = [itemList objectAtIndex:i];
		if (record.data.hpCurrent <= 0) {
			[deadFriends addObject:[NSNumber numberWithInt:i]];
		}
	}
	
	NSLog(@"Dead Friend Count: %d", [deadFriends count]);
	
	for (int i = 0; i + startIndex < [deadFriends count] && i < max_item_count; i++)
	{
		NSNumber *recordIndex = [deadFriends objectAtIndex:(i + startIndex)];
		CreatureRecord *record = [itemList objectAtIndex:[recordIndex intValue]];
		
		NSString *creatureName = [FDLocalString creature:record.definitionId];		
		FDSprite *nameSprite = [[FDSprite alloc] initWithString:creatureName Size:16];
		
		CCMenuItem *iconMenuItem = [CCMenuItemImage 
									itemFromNormalImage:[NSString stringWithFormat:@"Icon-%03d-02.png", record.definitionId] selectedImage:NULL
									target:self selector:@selector(clickedViewOn:)];
		iconMenuItem.position = ccp(startX + intervalX * (i % 3), startY - intervalY * (i / 3));
		iconMenuItem.tag = [recordIndex intValue];
		iconMenuItem.anchorPoint = ccp(0, 0);		
		
		CCMenuItemSprite* nameMenuItem = [CCMenuItemSprite itemFromNormalSprite:[nameSprite getSprite] selectedSprite:NULL target:self selector:@selector(clickedViewOn:)];
		
		nameMenuItem.position = ccp(startX + intervalX * (i % 3) + 25, startY - intervalY * (i / 3));
		nameMenuItem.tag = [recordIndex intValue];
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

-(NSMutableArray *) getShownList
{
	return deadFriends;
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