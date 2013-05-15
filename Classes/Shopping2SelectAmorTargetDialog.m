//
//  Shopping2SelectAmorTargetDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2SelectAmorTargetDialog.h"

#import "DataDepot.h"
#import "ButtonFactory.h"
#import "FDWindow.h"
#import "CreatureRecord.h"
#import "FDLocalString.h"

@implementation Shopping2SelectAmorTargetDialog

-(id) initWithFriends:(NSMutableArray *)list itemId:(int)iId pageIndex:(int)pIndex
{
	self = [super init];
	
	itemId = iId;
	[super initializeWithList:list pageIndex:pIndex];

	return self;
}

-(void) initComponents
{
	int startX = 15;
	int startY = 58;
	int intervalY = 26;
	
	int max_item_count = [self getMaxItemCount];
	int startIndex = pageIndex * max_item_count;
	
	suitableFriends = [[NSMutableArray alloc] init];
	for (int i = 0; i < [itemList count]; i++) {
		CreatureRecord *record = [itemList objectAtIndex:i];
		CreatureDefinition *creatureDef = [[DataDepot depot] getCreatureDefinition: record.definitionId];
		
		CCLOG(@"Creathre %d try equip %d.", i, itemId);
		if ([creatureDef canEquip:itemId]) {
			
			CCLOG(@"Passed. occu=%d", creatureDef.occupation);
			[suitableFriends addObject:[NSNumber numberWithInt:i]];
		}
	}
	
	CCLOG(@"Suitable Friend Count: %d", [suitableFriends count]);
	
	for (int i = 0; i + startIndex < [suitableFriends count] && i < max_item_count; i++)
	{
		NSNumber *recordIndex = [suitableFriends objectAtIndex:(i + startIndex)];
		CreatureRecord *record = [itemList objectAtIndex:[recordIndex intValue]];
		
		NSString *creatureName = [FDLocalString creature:record.definitionId];
		FDSprite *nameSprite = [[FDSprite alloc] initWithString:creatureName Size:16];
		
		CCMenuItem *iconMenuItem = [CCMenuItemImage 
									itemFromNormalImage:[NSString stringWithFormat:@"Icon-%03d-02.png", record.definitionId] selectedImage:NULL
									target:self selector:@selector(clickedViewOn:)];
		iconMenuItem.position = ccp(startX, startY - intervalY * i);
		iconMenuItem.tag = [recordIndex intValue];
		iconMenuItem.anchorPoint = ccp(0, 0);		
		
		CCMenuItemSprite* nameMenuItem = [CCMenuItemSprite itemFromNormalSprite:[nameSprite getSprite] selectedSprite:NULL target:self selector:@selector(clickedViewOn:)];
		
		nameMenuItem.position = ccp(startX + 25, startY - intervalY * i);
		nameMenuItem.tag = [recordIndex intValue];
		nameMenuItem.anchorPoint = ccp(0, 0);
		
		CCMenu *menu = [CCMenu menuWithItems:iconMenuItem, nameMenuItem, nil];
		menu.position = CGPointZero;
		[[baseSprite getSprite] addChild:menu];
		
		[nameSprite release];
		
		
		// AP
		NSString *ap = [NSString stringWithFormat:@"AP %03d -> %03d", [record.data calculatedAp], [record.data apWithItem:itemId]];
		[self addLabel:ap Location:CGPointMake(startX + 80, startY - intervalY * i + 10) Size:9];
		
		// DP
		NSString *dp = [NSString stringWithFormat:@"DP %03d -> %03d", [record.data calculatedDp], [record.data dpWithItem:itemId]];
		[self addLabel:dp Location:CGPointMake(startX + 80, startY - intervalY * i) Size:9];
		
		// HIT
		NSString *hit = [NSString stringWithFormat:@"HIT %03d -> %03d", [record.data calculatedHit], [record.data hitWithItem:itemId]];
		[self addLabel:hit Location:CGPointMake(startX + 150, startY - intervalY * i + 10) Size:9];
		
		// EV
		NSString *ev = [NSString stringWithFormat:@"EV  %03d -> %03d", [record.data calculatedEv], [record.data evWithItem:itemId]];
		[self addLabel:ev Location:CGPointMake(startX + 150, startY - intervalY * i) Size:9];		
		
		
		//CCSprite *icon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"Icon-%03d-02.png", definitionId]];
	}
}

-(int) getMaxItemCount
{
	return 3;
}

-(NSMutableArray *) getShownList
{
	return suitableFriends;
}

-(void) onClicked:(CGPoint)location
{
	// Do nothing
	/*
	int selected = 0;
	
	CCLOG(@"Select Target Index %d", selected);	
	id returnedObject = [NSNumber numberWithInt:selected];
	[self onExit:returnedObject];
	 */
}

-(void) dealloc
{
	if (suitableFriends != nil) {
		[suitableFriends release];
		suitableFriends = nil;
	}
	
	[super dealloc];
}

@end

