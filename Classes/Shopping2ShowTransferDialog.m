//
//  Shopping2ShowTransferDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-13.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ShowTransferDialog.h"
#import "DataDepot.h"

@implementation Shopping2ShowTransferDialog

-(id) initWithFriends:(NSMutableArray *)list pageIndex:(int)pIndex
{
	self = [super init];
	
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
	
	transferList = [[NSMutableArray alloc] init];
	for (int i = 0; i < [itemList count]; i++) {
		CreatureRecord *record = [itemList objectAtIndex:i];
		if (record.data.level < 20) {
			continue;
		}
		
		CreatureDefinition *creatureDef = [[DataDepot depot] getCreatureDefinition: record.definitionId];
		TransfersDefinition *transferDef = [[DataDepot depot] getTransfersDefinition:[creatureDef getId]];
		if (transferDef == nil || [transferDef totalCount] == 0) {
			continue;
		}
		
		NSLog(@"Found Transfer List for CreatureDef %d", [creatureDef getId]);
		
		for (int m = 0; m < [transferDef count]; m++) {
			TransferDefinition *def = [transferDef getTransfer:m];
			
			if (def.requireItemId == 0 || [record.data hasItem:def.requireItemId]) {
				NSLog(@"Adding Transfer Id=%d to list.", def.transferId);
				[transferList addObject:def];
			}
		}
	}
	
	NSLog(@"Available Transfer Count: %d", [transferList count]);
	
	for (int i = 0; i + startIndex < [transferList count] && i < max_item_count; i++)
	{
		TransferDefinition *transferDef = [transferList objectAtIndex:(i + startIndex)];
		CreatureDefinition *creatureDef = [[DataDepot depot] getCreatureDefinition:transferDef.fromCreatureDefId];
		CreatureDefinition *creatureNewDef = [[DataDepot depot] getCreatureDefinition:transferDef.toCreatureDefId];
		
		NSString *creatureName = [FDLocalString creature:creatureDefId];
		NSString *occupationName = [creatureDef getOccupationString];
		NSString *occupationNewName = [creatureNewDef getOccupationString];
		
		NSString *message = [NSString stringWithFormat:[FDLocalString message:70], occupationName, occupationNewName];
		FDSprite *messageSprite = [[FDSprite alloc] initWithString:message Size:16];
		
		CCMenuItem *iconMenuItem = [CCMenuItemImage 
									itemFromNormalImage:[NSString stringWithFormat:@"Icon-%03d-02.png", creatureDefId] selectedImage:NULL
									target:self selector:@selector(clickedViewOn:)];
		iconMenuItem.position = ccp(startX, startY - intervalY * i);
		iconMenuItem.tag = transferDef.transferId;
		iconMenuItem.anchorPoint = ccp(0, 0);		
		
		CCMenuItemSprite* messageMenuItem = [CCMenuItemSprite itemFromNormalSprite:[messageSprite getSprite] selectedSprite:NULL target:self selector:@selector(clickedViewOn:)];
		
		messageMenuItem.position = ccp(startX + 25, startY - intervalY * i);
		messageMenuItem.tag = transferDef.transferId;
		messageMenuItem.anchorPoint = ccp(0, 0);
		
		CCMenu *menu = [CCMenu menuWithItems:iconMenuItem, messageMenuItem, nil];
		menu.position = CGPointZero;
		[[baseSprite getSprite] addChild:menu];
		
		[messageSprite release];
	}
}

-(int) getMaxItemCount
{
	return 3;
}

-(void) dealloc
{
	if (transferList != nil) {
		[transferList release];
		transferList = nil;
	}
	
	[super dealloc];
}

@end
