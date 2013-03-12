//
//  ActionLayers.m
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "ActionLayers.h"
#import "BattleField.h"
#import "FDMoveCreatureActivity.h"
#import "FDExplodeActivity.h"
#import "FDTalkActivity.h"
#import "GameFormula.h"
#import "FDOperationActivity.h"
#import "TurnInfo.h"
#import "FDEmptyActivity.h"
#import "FDBatchActivity.h"
#import "UsableItemDefinition.h"
#import "DataDepot.h"
#import "ItemBox.h"
#import "MagicBox.h"
#import "ChapterInfo.h"
#import "FDLocalString.h"
#import "FightScene.h"
#import "MainGameScene.h"
#import "GameWinScene.h"
#import "GameOverScene.h"
#import "TitleScene.h"
#import "GameRecord.h"
#import "VillageScene.h"
#import "FightingInformation.h"
#import "FightingScene.h"
#import "MagicalInformation.h"
#import "MagicalScene.h"
#import "FDAudioEngine.h"

@implementation ActionLayers

-(id) initWithField:(BattleFieldLayer *)fLayer Message:(MessageLayer *)mLayer
{
	self = [super init];
	
	fieldLayer = fLayer;
	messageLayer = mLayer;
	
	field = [fieldLayer getField];
	
	activityList = [[NSMutableArray alloc] init];

	isLocked = FALSE;
	
	synchronizeTick = 0;
	SYNCHRONIZE_TOTAL_INT = 1000;

	sideBar = [[SideBar alloc] initWithField:field];
	[sideBar show:messageLayer];
	
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotificationUpdateSideBar:) name:@"LayerUpdateSideBar" object:nil];
    
	return self;
}

-(BattleFieldLayer *) getFieldLayer
{
	return fieldLayer;
}

-(MessageLayer *) getMessageLayer
{
	return messageLayer;
}

-(void) takeTick
{
	synchronizeTick = (synchronizeTick + 1) % SYNCHRONIZE_TOTAL_INT;

    [messageLayer updateScreen:synchronizeTick];
	
	if ([messageLayer getMessage] != nil) {
		// The message should block all the other ticks
		return;
	}
	
	[fieldLayer updateScreen:synchronizeTick];
	
    if (sideBar != nil) {
        [sideBar takeTick];
    }
    
    if (activityList == nil) {
        return;
    }
    
    /*
	for (FDActivity *activity in activityList) {
		
        [activity takeTick:synchronizeTick];
		NSLog(@"Activity takeTick");
		
		if ([activityList count] == 0) {
			break;
		}
		NSLog(@"Activity takeTick");
		
		if ([activity hasFinished]) {
			
			//[activity postActivity];
			if ([activity getNext] != nil) {
				[activityList addObject:[activity getNext]];
			}
			
			[activityList removeObject:activity];
		}
	}
    */
    
    int index = 0;
    int endIndex = [activityList count];
    while (activityList != nil && index < endIndex) {
        
        FDActivity *activity = [activityList objectAtIndex:index];
        
        [activity takeTick:synchronizeTick];
		// NSLog(@"Activity takeTick");
		
		if ([activity hasFinished]) {
			
			//[activity postActivity];
			if ([activity getNext] != nil) {
				[activityList addObject:[activity getNext]];
			}
			
			[activityList removeObject:activity];
            endIndex--;
		} else {
            index++;
        }
    }
}

-(void) appendNewActivity:(FDActivity *)activity
{
	[activityList addObject:activity];
}

-(void) appendToMainActivity:(FDActivity *)activity
{
	FDActivity *last = [activityList count] > 0 ? [activityList objectAtIndex:0] : nil;
	if (last == nil)
	{
		[activityList addObject:activity];
	}
	else {
		[last appendToLast:activity];
	}
}

-(void) clearAllActivity
{
	[activityList removeAllObjects];
}

-(void) appendToCurrentActivity:(FDActivity *)activity
{
	FDActivity *last = [activityList count] > 0 ? [activityList objectAtIndex:[activityList count]-1] : nil;
	if (last == nil)
	{
		[activityList addObject:activity];
	}
	else {
		[last appendToNext:activity];
	}	
}

-(void) appendToMainActivityMethod:(SEL)method Param1:(id)obj1 Param2:(id)obj2
{
	[self appendToMainActivityMethod:method Param1:obj1 Param2:obj2 Obj:self];
}

-(void) appendToMainActivityMethod:(SEL)method Param1:(id)obj1 Param2:(id)obj2 Obj:(id)obj
{
	FDOperationActivity *activity = [[FDOperationActivity alloc] initWithObject:obj Method:method Param1:obj1 Param2:obj2];
	[self appendToMainActivity:activity];
	[activity release];	
}


-(void) appendToCurrentActivityMethod:(SEL)method Param1:(id)obj1 Param2:(id)obj2
{
	[self appendToCurrentActivityMethod:method Param1:obj1 Param2:obj2 Obj:self];
}

-(void) appendToCurrentActivityMethod:(SEL)method Param1:(id)obj1 Param2:(id)obj2 Obj:(id)obj
{
	FDOperationActivity *activity = [[FDOperationActivity alloc] initWithObject:obj Method:method Param1:obj1 Param2:obj2];
	[self appendToCurrentActivity:activity];
	[activity release];	
}

-(void) prepareToMove:(FDCreature *)creature Location:(CGPoint)location
{
	// Show Creature Info
	
	creatureInfo = [[CreatureInfoBar alloc] initWithCreature:creature ClickedOn:location];
	[creatureInfo show:messageLayer];
}

-(void) clearCreatureInfo
{
	if (creatureInfo != nil) {
		[creatureInfo close];
		creatureInfo = nil;
	}
}

-(void) moveCreatureId:(int)creatureId To:(CGPoint)pos showMenu:(BOOL)willShowMenu
{
	FDCreature *creature = [field getCreatureById:creatureId];
	
	if (creature != nil) {
		[self moveCreature:creature To:pos showMenu:willShowMenu];
	}
}

-(void) moveCreature:(FDCreature *)creature To:(CGPoint)pos showMenu:(BOOL)willShowMenu
{
	if (creature == nil) {
		return;
	}
	
	// Set Cursor
	[field setCursorTo:[field getObjectPos:creature]];
	[field setCursorTo:pos];
	
	FDPath *path = [[[fieldLayer getField] getMovePath:creature To:pos] retain];
	
	for (int i = 0; i < [path getPosCount]; i++) {		
		[self moveCreatureSimple:creature To:[path getPos:i]];
	}
	
	if (![FDPosition isEqual:[field getObjectPos:creature] With:pos]) {
		creature.hasMoved = TRUE;
	}
	
	if (willShowMenu)
	{
		CGPoint p = [path getTargetPos];
		[self appendToMainActivityMethod:@selector(showMenuO:At:) Param1:[NSNumber numberWithInt: 1] Param2:[FDPosition positionX:p.x Y:p.y] Obj:field];
	}
	[path release];
}

-(void) moveCreatureIdSimple:(int)creatureId To:(CGPoint)pos
{
	FDCreature *creature = [field getCreatureById:creatureId];
	[self moveCreatureSimple:creature To:pos];
}

-(void) moveCreatureSimple:(FDCreature *)creature To:(CGPoint)pos
{
	CGPoint loc = [field convertPosToLoc:pos];
	
	FDMoveCreatureActivity *act = [[FDMoveCreatureActivity alloc] initWithObject:creature ToLocation:loc Speed:1.8];
	[self appendToCurrentActivity:act];
	[act release];
}

-(void) attackFrom:(FDCreature *)creature Target:(FDCreature *)target
{
	NSLog(@"Attack from %d to %d.", [creature getIdentifier], [target getIdentifier]);
	
	BOOL fightBack = [field isNextTo:creature And:target] && [target canFightBack];
	FightingInformation *fightingInfo = [GameFormula dealWithAttack:creature Target:target Field:field fightBack:fightBack];
	[fightingInfo retain];
	
	NSLog(@"fightingInfo attack1: %d %d", [[fightingInfo getAttackInfo1] getBefore], [[fightingInfo getAttackInfo1] getAfter]);
	
	CGPoint pos = [field getObjectPos:creature];
	int backgroundImageId = [field getBackgroundPicId:pos];
	FightingScene *scene = [[FightingScene alloc] initWithSubject:creature Target:target Information:fightingInfo Background:backgroundImageId];
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5 scene:scene]];
	
	[scene start];	
	[fightingInfo release];
	
	NSMutableArray *targets = [[NSMutableArray alloc] init];
	[targets addObject:target];
	[scene setPostMethod:@selector(postFightAction:Targets:) param1:creature param2:targets Obj:self];
}

-(void) postFightAction:(FDCreature *)creature Targets:(NSMutableArray *)targets
{
	NSLog(@"Post Method for attacking.");
	
	[targets retain];
	NSMutableArray *dropItemList = [[NSMutableArray alloc] init];
	
	// Check whether the important game event is triggered
	[eventListener isNotified];

	if (creature.data.hpCurrent <= 0) {
		
		FDExplodeActivity *activity = [[FDExplodeActivity alloc] initWithObject:creature Field:field];
		[self appendToCurrentActivity:activity];
		[activity release];
	}
	
	FDBatchActivity *activity = [[FDBatchActivity alloc] init];
	for (FDCreature *target in targets) {
		
			if (target.data.hpCurrent <= 0) {
				FDExplodeActivity *act = [[FDExplodeActivity alloc] initWithObject:target Field:field];
				[activity addActivity:act];
				[act release];
			}
	}
	[self appendToCurrentActivity:activity];
	[activity release];
	//[targets release];
	
	// Check whether the important game event is triggered
	//[self appendToCurrentActivityMethod:@selector(isNotified) Param1:nil Param2:nil Obj:eventListener];
	// [eventListener isNotified];
	
	NSLog(@"Analyse dead complete.");
	
	// Drop Item
	BOOL cannotCarryMore = FALSE;
	for (FDCreature *target in targets) {
		
		if ([target getCreatureType] == CreatureType_Enemy && target.data.hpCurrent <= 0) {
			
			FDEnemy *enemy = (FDEnemy *)target;
			ItemDefinition *dropItem = [[DataDepot depot] getItemDefinition:[enemy getDropItem]];
			if (dropItem != nil) {
				[dropItemList addObject:dropItem];
				
				if (![dropItem isMoney]) {
					// Add item
					if ([creature isItemListFull]) {
						cannotCarryMore = TRUE;
					} else {
						[creature.data.itemList addObject:[NSNumber numberWithInt:dropItem.identifier]];
					}
				} else {
					// Add money
					money += [dropItem getMoneyQuantity];
				}
			}
		}
	}
	
	// Talk about experience/drop item
	FDCreature *talkerFriend = nil;
	FDCreature *target = ([targets count] > 0) ? [targets objectAtIndex:0] : nil;
	if (creature != nil && [creature isKindOfClass:[FDFriend class]] && creature.lastGainedExperience > 0 && creature.data.hpCurrent > 0)
	{
		talkerFriend = creature;
	}
	else if (target != nil && [target isKindOfClass:[FDFriend class]] && target.lastGainedExperience > 0 && target.data.hpCurrent > 0)
	{
		talkerFriend = target;
	}
	
	if (talkerFriend != nil) {
	
		NSString *message = [NSString stringWithFormat:[FDLocalString message:5], talkerFriend.lastGainedExperience];
		FDTalkActivity *talk = [[FDTalkActivity alloc] initWithCreature:talkerFriend Message:message Layer:messageLayer];
		[self appendToMainActivity:talk];
		[talk release];
		
		NSString *levelUpMsg = [talkerFriend updateExpAndLevelUp];
		if (levelUpMsg != nil) {
			
			TalkMessage *message = [[TalkMessage alloc] initWithCreature:talkerFriend Message:levelUpMsg];
			[self appendToMainActivityMethod:@selector(show:) Param1:messageLayer Param2:nil Obj:message];
			// [message show:messageLayer];
		}
		
		for (ItemDefinition *dropItem in dropItemList) {
			NSString *message = [NSString stringWithFormat:[FDLocalString message:21], dropItem.name];
			FDTalkActivity *talk = [[FDTalkActivity alloc] initWithCreature:talkerFriend Message:message Layer:messageLayer];
			[self appendToMainActivity:talk];
			[talk release];			
		}
		
		if (cannotCarryMore) {
			FDTalkActivity *talk = [[FDTalkActivity alloc] initWithCreature:talkerFriend Message:[FDLocalString message:22] Layer:messageLayer];
			[self appendToMainActivity:talk];
			[talk release];
		}
	}
	
    NSLog(@"Notify.");
    
    // Check whether the important game event is triggered
    [self appendToMainActivityMethod:@selector(isNotified) Param1:nil Param2:nil Obj:eventListener];

	NSLog(@"End turn.");
	
	//End turn
	[self appendToMainActivityMethod:@selector(creatureActionDone:) Param1:creature Param2:nil Obj:self];
	
	[targets release];
	[dropItemList release];
}

-(void) magicFrom:(FDCreature *)creature TargetPos:(CGPoint)position Id:(int)magicId
{
	NSLog(@"Magic %d from %d to pos (%f, %f)", magicId, [creature getIdentifier], position.x, position.y);
	
	MagicDefinition *magic = [[DataDepot depot] getMagicDefinition:magicId];
	[creature updateMP:-magic.mpCost];
	[creature updateHP:0];
	
	BOOL areBadGuys = ([creature getCreatureType] == CreatureType_Friend && (magic.magicType == MagicType_Attack || magic.magicType == MagicType_Offensive))
					|| ([creature getCreatureType] == CreatureType_Enemy && (magic.magicType == MagicType_Recover || magic.magicType == MagicType_Defensive));
	
	NSMutableArray *targets = [field getCreaturesAt:position Range:magic.effectRange BadGuys:areBadGuys];
	NSLog(@"Target Creature count: %d", [targets count]);
	
	MagicalInformation *mInfo = [GameFormula dealWithMagic:magicId From:creature Target:targets Field:field];
	
	if (magic.magicType == MagicType_Attack) {
		CGPoint pos = [field getObjectPos:creature];
		int backgroundImageId = [field getBackgroundPicId:pos];
		MagicalScene *scene = [[MagicalScene alloc] initWithMagic:magicId Subject:creature Targets:targets Information:mInfo Background:backgroundImageId];
		[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5 scene:scene]];
		[scene start];	
		[scene setPostMethod:@selector(postFightAction:Targets:) param1:creature param2:targets Obj:self];
	} else {
		[self appendToMainActivityMethod:@selector(postFightAction:Targets:) Param1:creature Param2:targets Obj:self];
	}
}

/*
-(void) magicFrom:(FDCreature *)creature Targets:(NSArray *)targets Id:(int)magicId
{
	NSLog(@"Magic from %d to %d enemies", [creature getIdentifier], [targets count]);
	
	MagicDefinition *magic = [[DataDepot depot] getMagicDefinition:magicId];
	[creature updateMP:-magic.mpCost];
	[creature updateHP:0];
	
	MagicalInformation *mInfo = [GameFormula dealWithMagic:magicId From:creature Target:targets Field:field];
	
	CGPoint pos = [field getObjectPos:creature];
	int backgroundImageId = [field getBackgroundPicId:pos];
	MagicalScene *scene = [[MagicalScene alloc] initWithMagic:magicId Subject:creature Targets:targets Information:mInfo Background:backgroundImageId];
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5 scene:scene]];
	
	[scene start];	
	
	[scene setPostMethod:@selector(postFightAction:Targets:) param1:creature param2:targets Obj:self];
}
*/

-(void) useItem:(FDCreature *)creature ItemIndex:(int)itemIndex Target:(FDCreature *)target
{
	NSLog(@"Use Item.");
	
	int itemId = [creature getItemId:itemIndex];
	UsableItemDefinition * itemDef = (UsableItemDefinition *)[[DataDepot depot] getItemDefinition:itemId];
	[itemDef usedBy:target];
	
	[creature.data removeItem:itemIndex];
	
	[self appendToMainActivityMethod:@selector(creatureActionDone:) Param1:creature Param2:nil Obj:self];
}

-(void) giveItem:(FDCreature *)creature ItemIndex:(int)itemIndex Target:(FDCreature *)target
{
	NSLog(@"Gave Item.");
	
	int itemId = [creature getItemId:itemIndex];
	
	[creature.data removeItem:itemIndex];
	[target addItem:itemId];
	
	creature.hasActioned = TRUE;
}

-(void) exchangeItem:(FDCreature *)creature ItemIndex:(int)itemIndex Target:(FDCreature *)target ItemIndex:(int)backItemIndex
{
	NSLog(@"Exchange Item.");
	
	int itemId = [creature getItemId:itemIndex];
	int backItemId = [target getItemId:backItemIndex];

	[creature.data removeItem:itemIndex];
	[target.data removeItem:backItemIndex];

	[target addItem:itemId];
	[creature addItem:backItemId];

	creature.hasActioned = TRUE;
}

-(void) pickUpTreasure:(FDCreature *) creature
{
	FDTreasure *treasure = [field getTreasureAt:[field getObjectPos:creature]];
	
	if (treasure == nil || [treasure hasOpened]) {
		return;
	}
	
	NSLog(@"Creature picked up the treasure.");
	
	[treasure setOpened];
	ItemDefinition *item = [treasure getItem];
	
	// If the treasure is money, add to money
	if ([item isMoney]) {
		// Add to money
		money += [item getMoneyQuantity];
		return;
	}
	else {
		[creature.data.itemList addObject:[NSNumber numberWithInt:item.identifier]];
	}
}

-(void) exchangeTreasure:(FDCreature *)creature withItem:(int)itemIndex
{
	FDTreasure *treasure = [field getTreasureAt:[field getObjectPos:creature]];
	
	if (treasure == nil || [treasure hasOpened])
	{
		return;
	}
	
	NSLog(@"Exchange picked up the treasure.");
	
	ItemDefinition *item = [treasure getItem];

	// Note: the item could not be money
	
	[creature.data.itemList addObject:[NSNumber numberWithInt:item.identifier]];
	
	[treasure changeItemId:[[creature.data.itemList objectAtIndex:itemIndex] intValue]];

	[creature dropItem:itemIndex];
}

-(void) creatureActionDone:(FDCreature *)creature
{
    if (creature != nil) {
		
		creature.hasActioned = TRUE;
		
		[self appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil Obj:self];
	}
}

-(void) creatureEndTurn:(FDCreature *)creature
{
	NSLog(@"End turn for creature %d", [creature getIdentifier]);
	
	// Recover some HP
	if (!creature.hasMoved && !creature.hasActioned) {
		int recoverHp = [GameFormula recoverHpFromRest:creature];
		
		NSLog(@"Recover HP %d for creature.", recoverHp);
		[creature updateHP:recoverHp];
	}
	
	[creature endTurn];
	
	if ([creature getCreatureType] == CreatureType_Enemy) {
		//[enemyAiHandler isNotified];
		[self appendToCurrentActivityMethod:@selector(isNotified) Param1:nil Param2:nil Obj:enemyAiHandler];
	}
	else if ([creature getCreatureType] == CreatureType_Npc) {
		//[npcAiHandler isNotified];
		[self appendToCurrentActivityMethod:@selector(isNotified) Param1:nil Param2:nil Obj:npcAiHandler];
	}
	
    // Check end turn
    [self appendToCurrentActivityMethod:@selector(checkEndTurn) Param1:nil Param2:nil Obj:self];
    
    [self appendToCurrentActivityMethod:@selector(isNotified) Param1:nil Param2:nil Obj:eventListener];
}

-(void) creaturePendAction:(FDCreature *)creature
{
	NSLog(@"Pend Action for creature %d", [creature getIdentifier]);
	
	[creature pendAction];
	
	if ([creature getCreatureType] == CreatureType_Enemy) {
		//[enemyAiHandler isNotified];
		[self appendToCurrentActivityMethod:@selector(isNotified) Param1:nil Param2:nil Obj:enemyAiHandler];
	}
	if ([creature getCreatureType] == CreatureType_Npc) {
		//[npcAiHandler isNotified];
		[self appendToCurrentActivityMethod:@selector(isNotified) Param1:nil Param2:nil Obj:npcAiHandler];
	}
}

-(void) checkEndTurn
{
	NSLog(@"Checking End Turn...");
	
	if (turnType == TurnType_Friend)
	{
		for (FDCreature *creature in [field getFriendList]) {
			if (!creature.hasActioned && [creature isNotFrozen]) {
				return;
			}
		}
		[self endFriendTurn];
	}
	else if	(turnType == TurnType_NPC)
	{
		for (FDCreature *creature in [field getNpcList]) {
			if (!creature.hasActioned && [creature isNotFrozen]) {
				return;
			}
		}
		[self endNpcTurn];
	}
	else if (turnType == TurnType_Enemy)
	{
		for (FDCreature *creature in [field getEnemyList]) {
			if (!creature.hasActioned && [creature isNotFrozen]) {
				return;
			}
		}
		[self endEnemyTurn];
	}
}

-(void) startFriendTurn
{
	NSLog(@"Start Friend Turn");
	
	turnType = TurnType_Friend;
	
	// reset all creatures
	[field startNewTurn];
	
	NSLog(@"Stared NewTurn %d", [self isInteractiveBusy]);
	if ([self isInteractiveBusy]) {
		NSLog(@"isInteractiveBusy");
	}
	
	// Show the turn Number
	[self appendToMainActivityMethod:@selector(showTurnInfo) Param1:nil Param2:nil];
	
	// Set Cursor the first friend
	FDCreature *firstFriend = [[field getFriendList] objectAtIndex:0];
	CGPoint pos = [field getObjectPos:firstFriend];
	[self appendToMainActivityMethod:@selector(setCursorObjTo:) Param1:[FDPosition positionX:pos.x Y:pos.y] Param2:nil Obj:field];
    
    if (turnNo == 1) {
        // Play Background Music
        [FDAudioEngine playBattleGroundMusic:chapterId];
    }
}

-(void) endFriendTurn
{
	NSLog(@"End Friend Turn");
	
	// End all friends
	for (FDCreature *friend in [field getFriendList]) {
		[self creatureEndTurn:friend];
	}
	
	// Trigger the friend turn actions
	[eventListener isNotified];
	//[npcAiHandler isNotified];
	
	// To Avoid seeing so many disabled friends, enable them just after user interaction finished.
	for (FDCreature *friend in [field getFriendList]) {
		[friend startTurn];
	}
	
	[self appendToMainActivityMethod:@selector(startNpcTurn) Param1:nil Param2:nil];
}

-(void) startNpcTurn
{
	NSLog(@"Start Npc Turn");

	turnType = TurnType_NPC;

	// If there is no NPC actionable
	BOOL hasActionableTarget = FALSE;
	for (FDCreature *creature in [field getNpcList]) {
		if (creature.data.statusFrozen <= 0) {
			hasActionableTarget = TRUE;
			break;
		}
	}
	
	if (hasActionableTarget) {
		turnType = TurnType_NPC;
		[npcAiHandler isNotified];
	}
	else {
		[self endNpcTurn];
	}
}

-(void) endNpcTurn
{
	NSLog(@"End Npc Turn");
	
	// End all Npcs
	for (FDCreature *npc in [field getNpcList]) {
		[npc endTurn];
	}
	
	// Trigger the Npc turn actions
	[eventListener isNotified];

	// To Avoid seeing so many disabled NPCs, enable them just after user interaction finished.
	for (FDCreature *npc in [field getNpcList]) {
		[npc startTurn];
	}
	
	[self appendToMainActivityMethod:@selector(startEnemyTurn) Param1:nil Param2:nil];
}

-(void) startEnemyTurn
{
	NSLog(@"Start Enemy Turn");

	turnType = TurnType_Enemy;
	
	// If there is no NPC actionable
	BOOL hasActionableTarget = FALSE;
	for (FDCreature *creature in [field getEnemyList]) {
		if (creature.data.statusFrozen <= 0) {
			hasActionableTarget = TRUE;
			break;
		}
	}
	
	if (hasActionableTarget) {
		[enemyAiHandler isNotified];
	}
	else {
		[self endEnemyTurn];
	}
}

-(void) endEnemyTurn
{
	NSLog(@"End Enemy Turn");

	// End all enemies
	for (FDCreature *enemy in [field getEnemyList]) {
		[enemy endTurn];
	}
	
	// Trigger Events
	[eventListener isNotified];
	
	// Status checking
	for (FDCreature *c in [field getFriendList]) {
		[c.data updateStatusInTurn];
	}
	for (FDCreature *c in [field getNpcList]) {
		[c.data updateStatusInTurn];
	}
	for (FDCreature *c in [field getEnemyList]) {
		[c.data updateStatusInTurn];
	}
	
	// Show new turn
	turnNo ++;
	[self appendToMainActivityMethod:@selector(startFriendTurn) Param1:nil Param2:nil];
}

-(void) startNewGame:(ChapterRecord *)info
{
	//[field loadMapData:level];
	chapterId = info.chapterId;
	turnNo = 0;
	money = info.money;
	
    // Stop previous background Music
    [FDAudioEngine stopMusic];
    
	// Load Friends
	for(CreatureRecord *record in [info friendRecords])
	{
		FDFriend *creature = [[FDFriend alloc] initWithDefinition:record.definitionId Id:record.creatureId Data:record.data];
		
		if (creature.data.hpCurrent > 0) {
			[[field getUnsettledCreatureList] addObject:creature];
		} else {
			[[field getDeadCreatureList] addObject:creature];
		}

		[creature release];
	}
	
	[self runGame];
}

-(void) loadGame:(BattleRecord *)info // withEvents:(BOOL)loadEvents
{
	//[field loadMapData:info.levelNo];
	
	chapterId = info.chapterId;
	turnNo = info.turnNo;
	money = info.money;
	
    // Load Creatures
	for(CreatureRecord *record in [info friendRecords])
	{
		FDFriend *creature = [[FDFriend alloc] initWithDefinition:record.definitionId Id:record.creatureId Data:record.data];
		[field addFriend:creature Position:record.location];
		[creature release];
		
	}
	
	for(CreatureRecord *record in [info enemyRecords])
	{
		FDEnemy *creature = [[FDEnemy alloc] initWithDefinition:record.definitionId Id:record.creatureId Data:record.data];
		[field addEnemy:creature Position:record.location];
		[creature release];
		
	}
	for(CreatureRecord *record in [info npcRecords])
	{
		FDNpc *creature = [[FDNpc alloc] initWithDefinition:record.definitionId Id:record.creatureId Data:record.data];
		[field addNpc:creature Position:record.location];
		[creature release];
		
	}
	
	for(CreatureRecord *record in [info deadCreatureRecords])
	{
		FDCreature *creature = nil;
		
		switch (record.creatureType) {
			case CreatureType_Friend:
				creature = [[FDFriend alloc] initWithDefinition:record.definitionId Id:record.creatureId Data:record.data];
				break;
			case CreatureType_Enemy:
				creature = [[FDEnemy alloc] initWithDefinition:record.definitionId Id:record.creatureId Data:record.data];
				break;
			case CreatureType_Npc:
				creature = [[FDNpc alloc] initWithDefinition:record.definitionId Id:record.creatureId Data:record.data];
				break;
			default:
				break;
		}
		[[field getDeadCreatureList] addObject:creature];
		[creature release];
	}
	
	for (TreasureRecord *record in [info treasureRecords]) {
		FDTreasure *treasure = [field getTreasureAt:record.location];
		if (treasure != nil) {
			
			if (record.hasOpened) {
				[treasure setOpened];
			}
			else {
				[treasure changeItemId:record.itemId];
			}
		}
	}
	
	// Load the active events
	if (!info.withAllEvents) {
		[eventListener loadState:[info activeEventIds]];
	}
	
	turnNo --;
	
    // Play background music
    [FDAudioEngine playBattleGroundMusic:chapterId];
	
    [self runGame];
}

-(void) runGame
{
	turnType = TurnType_Friend;
	
	// Trigger Events
	[eventListener isNotified];
	
	// Show new turn
	turnNo ++;
	[self appendToMainActivityMethod:@selector(startFriendTurn) Param1:nil Param2:nil];	
}

-(void) saveGame
{
	NSLog(@"Saving Game");
	
	BattleRecord *info = [[BattleRecord alloc] initWithChapter:chapterId];
	info.turnNo = turnNo;
	info.money = money;
	
	for(FDCreature *creature in [field getFriendList])
	{
		CreatureRecord *record = [field generateCreatureRecord:creature];
		[[info friendRecords] addObject:record];
	}
	
	for(FDCreature *creature in [field getEnemyList])
	{
		CreatureRecord *record = [field generateCreatureRecord:creature];
		[[info enemyRecords] addObject:record];
	}
	
	for(FDCreature *creature in [field getNpcList])
	{
		CreatureRecord *record = [field generateCreatureRecord:creature];
		[[info npcRecords] addObject:record];
	}
	
	for(FDCreature *creature in [field getDeadCreatureList])
	{
		CreatureRecord *record = [field generateCreatureRecord:creature];
		[[info deadCreatureRecords] addObject:record];
	}
	
	NSMutableArray *treasureList = [field getTreasureList];
	for (FDTreasure *treasure in treasureList) {
		TreasureRecord *record = [field generateTreasureRecord:treasure];
		[[info treasureRecords] addObject:record];
	}
	
	NSMutableArray *activeEventIds = [eventListener saveState];
	[[info activeEventIds] addObjectsFromArray:activeEventIds];
	
	
	GameRecord *gameRecord = [[GameRecord readFromSavedFile] retain];
	[gameRecord setBattleRecord:info];
	[gameRecord saveRecord];
	
	[info release];
	[gameRecord release];
}

-(ChapterRecord *) composeChapterRecord
{
	ChapterRecord *record = [[ChapterRecord alloc] initWithChapter:chapterId + 1];
	record.money = money;
	
	for(FDCreature *creature in [field getFriendList])
	{
		CreatureRecord *r = [field generateCreatureRecord:creature];
		[r.data recoverHealth];
		[r.data clearAllStatus];
		
		[[record friendRecords] addObject:r];
	}
	
	for (FDCreature *creature in [field getDeadCreatureList]) {
		
		if ([creature getCreatureType] == CreatureType_Friend) {
			CreatureRecord *r = [field generateCreatureRecord:creature];
			[r.data recoverHealth];
			[r.data clearAllStatus];
			
			[[record friendRecords] addObject:r];
		}
	}
	
	[[record friendRecords] sortUsingSelector:@selector(compareRecords:)];
	
	return record;
}

-(void) notifyEventListener {
    
    [eventListener isNotified];
}

-(void) showItemStatus:(FDCreature *)creature
{
	NSLog(@"Show creature item status");
	
	ItemBox *ibox = [[ItemBox alloc] initWithCreature:creature Type:ItemOperatingType_ShowOnly];
	[ibox show:messageLayer];	
}

-(void) showMagicStatus:(FDCreature *)creature
{
	NSLog(@"Show creature magic status");
	
	MagicBox *box = [[MagicBox alloc] initWithCreature:creature Type:MagicOperatingType_ShowOnly];
	[box show:messageLayer];	
}

-(void) showItemStatusAsync:(FDCreature *)creature
{
	[self appendToCurrentActivityMethod:@selector(showItemStatus:) Param1:creature Param2:nil];
}

-(void) showMagicStatusAsync:(FDCreature *)creature
{
	[self appendToCurrentActivityMethod:@selector(showMagicStatus:) Param1:creature Param2:nil];
}

-(void) showTurnInfo
{
	TurnInfo *info = [[TurnInfo alloc] initWithNo:turnNo];
	[info show:messageLayer];
	[info release];
}

-(void) showChapterInfo
{
	ChapterInfo *info = [[ChapterInfo alloc] init];
	
	[info setFriendCount:[[field getFriendList] count] EnemyCount:[[field getEnemyList] count] NpcCount:[[field getNpcList] count]];
	[info setChapterNo:chapterId TurnNo:turnNo];
	[info setCondition:chapterId];
	[info setMoney:money];
	
	[info show:messageLayer];
	[info release];	
}

-(void) receiveNotificationUpdateSideBar:(NSNotification *)notification {
    
    CGPoint cursor = [field getCursorPos];
    NSLog(@"Notification Received. (%f, %f)", cursor.x, cursor.y);
    
    @try {
        
    if (sideBar != nil) {
        [sideBar updateContent];
    }
    }
    @catch (NSException *exception) {

    }
}

-(void) gameCleared {
    
    // Stop background music
    [FDAudioEngine stopMusic];
}

-(void) gameOver
{
	// [self clearAllActivity];
	
	GameOverScene *scene = [GameOverScene node];
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5 scene:scene]];	
}

-(void) gameWin
{
	[self clearAllActivity];
	NSLog(@"Game Win.");
	
	//ChapterRecord *record = [ChapterRecord sampleRecord];
	ChapterRecord *record = [self composeChapterRecord];
	
	if (chapterId < 15) {
		VillageScene *scene = [VillageScene node];
		[scene loadWithRecord:record];
		[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.5 scene:scene]];	
	} else {
		GameWinScene *scene = [GameWinScene node];
		[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.5 scene:scene]];	
	}
}

-(void) gameQuit
{
	NSLog(@"Game Quit.");
	
	[self clearAllActivity];
	
	TitleScene *scene = [TitleScene node];
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];	
}

-(void) gameContinue
{
	GameRecord *record = [GameRecord readFromSavedFile];
	BattleRecord *info = [record.battleRecord retain];
	//[record saveRecord];
	
	MainGameScene *mainGame = [MainGameScene node];
	[mainGame loadWithInfo:info];
	
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:mainGame]];
	
	[info release];
}

-(int) getTurnNumber
{
	return turnNo;
}

-(TurnType) getTurnType
{
	return turnType;
}

-(BOOL) isInteractiveBusy
{
	for(FDActivity *activity in activityList)
	{
		if ([activity blocksInteraction]) {
			return TRUE;
		}
	}
	return FALSE;
}

-(BOOL) isLocked
{
	return isLocked;
}


-(void) setEventListener:(IListener *)listener
{
	eventListener = [listener retain];
}

-(void) setEnemyAiHandler:(IListener *)listener
{
	enemyAiHandler = [listener retain];
}

-(void) setNpcAiHandler:(IListener *)listener
{
	npcAiHandler = [listener retain];
}

-(void) showTestData
{
	FDActivity *a = [activityList objectAtIndex:[activityList count]-1];
	while (a !=nil) {
		
		//NSLog([a debugInfo]);
		a = [a getNext];
	}
}

-(void) dealloc
{
	[activityList release];
	
	if (eventListener != nil) {
		[eventListener release];
		eventListener = nil;
	}
	
	if (enemyAiHandler != nil) {
		[enemyAiHandler release];
		enemyAiHandler = nil;
	}
	
	if (npcAiHandler != nil) {
		[npcAiHandler release];
		npcAiHandler = nil;
	}
	
	
	[super dealloc];
	
}


@end
