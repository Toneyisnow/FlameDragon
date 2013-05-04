//
//  BattleField.m
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "CCDirector.h"

#import "BattleField.h"
#import "Constants.h"
#import "Common.h"

#import "FDFriendFactory.h"
#import "FDFriend.h"
#import "FDEnemy.h"
#import "FDScopeIndicator.h"
#import "FDMenuItem.h"
#import "FDTreasure.h"
#import "FDWindow.h"

#import "FDMoveCreatureActivity.h"
#import "ScopeResolver.h"
#import "PathResolver.h"
#import "ChapterLoader.h"

#import "FDPosition.h"
#import "FDPosition.h"
#import "FDIntMap.h"

#import "DataDepot.h"

#import "FightScene.h"
#import "FightTargetInfo.h"

#import "GameFormula.h"

@implementation BattleField


-(id) initWithChapter:(int)chapterId
{
	self = [super init];
	
	battleObjectList = [[NSMutableArray alloc] init];
	friendList = [[NSMutableArray alloc] init];
	npcList = [[NSMutableArray alloc] init];
	enemyList = [[NSMutableArray alloc] init];	
	deadCreatureList = [[NSMutableArray alloc] init];
	unsettledCreatureList = [[NSMutableArray alloc] init];
	
	groundImage = [[FDSprite alloc] initFromFile:[NSString stringWithFormat:@"Chapter-%02d.png", chapterId]];
	[groundImage retain];
	
	fieldChapterId = chapterId;
	
	[self loadMapData:chapterId];

	return self;
}

-(void) loadMapData:(int)chapterId
{
	FDFileStream *fileStream = [[FDFileStream alloc] initWithDataFile:[NSString stringWithFormat:@"Chapter-%02d", chapterId]];
	[fileStream open];
	
	groundField = [[GroundField alloc] initWithDefinitionStream:fileStream];
	
	fieldWidth  = [groundField fieldSize].width;
	fieldHeight = [groundField fieldSize].height;
	
	NSLog(@"Field Width:%d Height:%d", fieldWidth, fieldHeight);
	
	// Load Treasure
	int treasureCount = [fileStream readInt];
	for (int i = 0; i < treasureCount; i++) {
		int posX = [fileStream readInt];
		int posY = [fileStream readInt];
		TreasureType type = [fileStream readInt];
		int itemId = [fileStream readInt];
		
		FDTreasure *treasure = [[FDTreasure alloc] initWithType:type Item:itemId];
		[self addObject:treasure Position:CGPointMake(posX, posY)];
		[treasure release];
        
		NSLog(@"Loaded treasure %d at (%d, %d).", itemId, posX, posY);
	}
	
	[fileStream close];
	[fileStream release];
	
	[groundImage setLocation:CGPointMake(400, 300)];
	
	cursor = [[FDCursor alloc] init];
	[self addObject:cursor Position:CGPointMake(1, 1)];

	//[self showTestData];
}


-(GroundField *) getGroundField
{
	return groundField;
}

-(void) addFriend:(FDFriend *)fri Position:(CGPoint)pos
{
	[self addObject:fri Position:pos];
	[friendList addObject:fri];
}

-(void) addEnemy:(FDEnemy *)cre Position:(CGPoint)pos
{
	[self addObject:cre Position:pos];
	[enemyList addObject:cre];
}

-(void) addNpc:(FDNpc *)npc Position:(CGPoint)pos
{
	[self addObject:npc Position:pos];
	[npcList addObject:npc];
}

-(void) addEnemy:(FDEnemy *)cre Around:(CGPoint)pos
{
	CGPoint aroundPos[9] = {
		CGPointMake(0, 0),
		CGPointMake(1, 0),
		CGPointMake(1, 1),
		CGPointMake(0, 1),
		CGPointMake(-1, 1),
		CGPointMake(-1, 0),
		CGPointMake(-1, -1),
		CGPointMake(0, -1),
		CGPointMake(1, -1)
	};
	
	for (int i = 0; i < 9; i++)
	{
		CGPoint nowPos = CGPointMake(pos.x + aroundPos[i].x, pos.y + aroundPos[i].y);
		if ([self getCreatureByPos:nowPos] == nil) {
			[self addEnemy:cre Position:nowPos];
			return;
		}
	}
}

-(void) addObject:(FDBattleObject *)obj Position:(CGPoint)pos
{
	CGPoint location = [self convertPosToLoc:pos];	
	[[obj getSprite] setLocation:location];
	
	[groundImage addSprite:[obj getSprite] zOrder:[obj zOrder]];
	
	[battleObjectList addObject:obj];
}

-(void) removeObject:(FDBattleObject *)obj
{
	if ([obj isKindOfClass:[FDFriend class]]) {
		[friendList removeObject:obj];
	}
	if ([obj isKindOfClass:[FDEnemy class]]) {
		[enemyList removeObject:obj];
	}
	if ([obj isKindOfClass:[FDNpc class]]) {
		[npcList removeObject:obj];
		
	}
	
	[groundImage removeSprite:[obj getSprite]];
	[battleObjectList removeObject:obj];
	
	// NSLog(@" Removed object. Friend=%d Enemy=%d Npc=%d All=%d", [friendList count], [enemyList count], [npcList count], [battleObjectList count]);
	
}

-(CGPoint) convertPosToLoc:(CGPoint)pos
{
	float locX = (pos.x - 0.5) * [Constants unitSize];
	float locY = (fieldHeight - pos.y + 0.5) * [Constants unitSize];
	
	return CGPointMake(locX, locY);
}

-(CGPoint) convertLocToPos:(CGPoint)loc
{
	int posX = loc.x / [Constants unitSize] + 1;
	int posY = fieldHeight - loc.y / [Constants unitSize] + 1;
	
	return CGPointMake(posX, posY);
}

-(CGPoint) getMapLocationbyScreen:(CGPoint)loc
{
	float locX = (loc.x + [groundImage size].width / 2 - [groundImage location].x) / [Constants battleMapScale];
	float locY = (loc.y + [groundImage size].height / 2 - [groundImage location].y) / [Constants battleMapScale];
	
	return CGPointMake(locX, locY);
}

-(CGPoint) getScreenLocationbyMap:(CGPoint)loc
{
	float locX = loc.x * [Constants battleMapScale] - [groundImage size].width / 2 + [groundImage location].x;
	float locY = loc.y * [Constants battleMapScale] - [groundImage size].height / 2 + [groundImage location].y;
	
	return CGPointMake(locX, locY);
}

-(void) takeTick:(int)synchronizeTick
{
	for(FDBattleObject *obj in battleObjectList)
	{
		[obj takeTick:synchronizeTick];
	}
}

-(void) removeAllIndicators
{
	for(int i = [battleObjectList count]-1; i >= 0; i--)
	{
		FDBattleObject *obj = [battleObjectList objectAtIndex:i];
		if ([obj isKindOfClass:[FDScopeIndicator class]])
		{
			[self removeObject:obj];
		}
	}
}

////////////////// IFieldActionable ///////////////////

-(void) prepareToMove:(FDCreature *)creature
{
	creature.hasMoved = FALSE;
	NSMutableArray *unitList = [[self searchMoveScope:creature] retain];
	
	for(FDPosition *pos in unitList)
	{
		FDScopeIndicator *indicator = [[FDScopeIndicator alloc] init];
		[self addObject:indicator Position:[pos posValue]];
		[indicator release];
	}
	[unitList release];
}

-(void) moveCreature:(FDCreature *)creature To:(CGPoint)pos showMenu:(BOOL)willShowMenu
{
}

-(FDPath *) getMovePath:(FDCreature *)creature To:(CGPoint)pos
{
	// Pre work before moving
	[self removeAllIndicators];
	[creature preMove:[self getObjectPos:creature]];
	
	CreatureType enemyType1 = CreatureType_Friend;
	CreatureType enemyType2 = CreatureType_Friend;
	
	if ([creature getCreatureType] == CreatureType_Friend || [creature getCreatureType] == CreatureType_Npc)
	{
		enemyType1 = enemyType2 = CreatureType_Enemy;
	}
	
	if ([creature getCreatureType] == CreatureType_Enemy)
	{
		enemyType1 = CreatureType_Friend;
		enemyType2 = CreatureType_Npc;
	}
	
	FDIntMap *map = nil;
    
    if ([creature canFly]) {
        map = [[groundField getGroundPathMapForFly] clone];
    } else {
        map = [[groundField getGroundPathMapForGround] clone];
    }
    
	for (int i = 1; i <= fieldWidth; i++) {
		for (int j = 1; j <= fieldHeight; j++) {
			
			FDCreature *c = [self getCreatureByPos:CGPointMake(i, j)];
			if (c != nil && ([c getCreatureType] == enemyType1 || [c getCreatureType] == enemyType2))
			{
				[map setX:i Y:j Value: PathBlockType_Blocked];
			}
		}
	}
	
	PathResolver *resolver = [[PathResolver alloc] initWithMap:map Width:fieldWidth Height:fieldHeight];
	
	FDPath *path = [resolver resolvePathFrom:[self getObjectPos:creature] To:pos MaxStep:creature.data.mv];
	[path retain];
	[resolver release];

	return [path autorelease];
	
}

-(void) cancelPrepare:(FDCreature *)creature
{
	[self removeAllIndicators];
}

-(void) showMenuO:(NSNumber *)menuId At:(FDPosition *)pos
{
	[self showMenu:[menuId intValue] At:[pos posValue]];
}

-(void) showMenu:(int)menuId At:(CGPoint)pos
{
	NSLog(@"Showing menu %d at position (%f, %f)", menuId, pos.x, pos.y);
	
	FDCreature *creature = [self getCreatureByPos:pos];

	if ((menuId == 1 || menuId == 2) && creature == nil) {
		NSLog(@"Error: Showing menu with nil creature");
		return;
	}
	
	int menuItemId[4] = { menuId * 10, menuId * 10 + 1, menuId * 10 + 2, menuId * 10 + 3};
	CGPoint menuPos[4];
	menuPos[0] = CGPointMake(pos.x-1, pos.y);
	menuPos[1] = CGPointMake(pos.x, pos.y-1);
	menuPos[2] = CGPointMake(pos.x+1, pos.y);
	menuPos[3] = CGPointMake(pos.x, pos.y+1);
	
	BOOL selected = FALSE;
	for (int i = 0; i < 4; i++) {
		
		FDMenuItem *item = [[FDMenuItem alloc] initWithId:menuItemId[i]];
		
		BOOL isValid = TRUE;
		switch (menuItemId[i]) {
			case 10:
				// Magic
				isValid = [creature canFireMagic]; 
				break;
			case 11:
				// Attack
				isValid = ([[self getEnemyInAttackScope:creature] count] > 0); 
				break;
			case 12:
				// Item
				isValid = TRUE; 
				break;
			case 13:
				// End Turn
				isValid = TRUE; 
				break;
			case 20:
				// Exchange Item
				isValid = ([creature.data.itemList count] > 0 && [[self getNearByFriend:creature] count] > 0);
				break;
			case 21:
				// Use Item
				isValid = ([creature.data.itemList count] > 0); 
				break;
			case 22:
				// Equipment
				isValid = ([creature.data.itemList count] > 0); 
				break;
			case 23:
				// Drop
				isValid = ([creature.data.itemList count] > 0);
				break;
			case 30:
				// March
				isValid = FALSE;
				break;
			case 40:
				// Save Current Game
				isValid = TRUE;
				for (FDCreature *creature in friendList) {
					if ([creature hasMoved] || [creature hasActioned]) {
						isValid = FALSE;
						break;
					}
				}
				break;
			default:
				break;
		}
		[item setValid:isValid];
		
		if (isValid && !selected) {
			[item setSelected:TRUE];
			selected = TRUE;
		}
		
		[self addObject:item Position:menuPos[i]];
	}
}

-(void) selectMenuItem:(FDMenuItem *)item
{
	for (FDBattleObject *obj in battleObjectList) {
		if ([obj isKindOfClass:[FDMenuItem class]]) {
			FDMenuItem *i = (FDMenuItem *)obj;
			[i setSelected:FALSE];
		}
	}
	[item setSelected:TRUE];
}

-(void) closeMenu
{
	for (int i = [battleObjectList count]-1; i >= 0; i--) {
		if ([[battleObjectList objectAtIndex:i] isKindOfClass:[FDMenuItem class]]) {
			[self removeObject:[battleObjectList objectAtIndex:i]];
		}
	}
}

-(void) showConfirmMessage:(FDCreature *)creature MessageId:(int)messageId
{
	
}


-(void) shwoActionMenu:(int)menuId For:(FDCreature *)creature
{
}

-(void) showSystemMenu:(int)menuId At:(CGPoint)centralPos
{
}

-(void) selectAttackTarget:(FDCreature *)creature
{
	NSMutableArray *scopeList = [self searchActionScope:[self getObjectPos:creature] Range:[creature attackRange]];
	
	if (scopeList == nil) {
		return;
	}
	
	for(FDPosition *pos in scopeList)
	{
		FDScopeIndicator *indicator = [[FDScopeIndicator alloc] init];
		
		[self addObject:indicator Position:[pos posValue]];
		[indicator release];
	}
}

-(void) selectMagicTarget:(FDCreature *)creature MagicIndex:(int)magicIndex
{
	int magicId = [[creature.data.magicList objectAtIndex:magicIndex] intValue];
	MagicDefinition * magic = [[DataDepot depot] getMagicDefinition:magicId];
	FDRange *scope = [[FDRange alloc] initWithMin:0 Max:magic.effectScope];
	
	NSMutableArray *scopeList = [self searchActionScope:[self getObjectPos:creature] Range:scope];
	
	for(FDPosition *pos in scopeList)
	{
		FDScopeIndicator *indicator = [[FDScopeIndicator alloc] init];
		
		[self addObject:indicator Position:[pos posValue]];
		[indicator release];
	}
	
	[scope release];
    
    // Set Cursor Size
    [self setCursorSize:magic.effectRange + 1];
    
}

// DEPRECATED
/*
-(NSMutableArray *) getMagicTargets:(int)magicId Pos:(CGPoint)position
{
	NSMutableArray *resultArray = [[NSMutableArray alloc] init];
	
	// Magic Scope
	MagicDefinition *magic = [[DataDepot depot] getMagicDefinition:magicId];
	FDRange *range = [[FDRange alloc] initWithMin:0 Max:magic.effectRange];
	
	NSMutableArray *scopeList = [self searchActionScope:position Range:range];
	
	for(FDPosition *pos in scopeList)
	{
		FDCreature *creature = [self getCreatureByPos:[pos posValue]];
		if (magic.magicType == MagicType_Attack && [creature isKindOfClass:[FDEnemy class]]) {
			[resultArray addObject: creature];
		}
	}
	[range release];
	
	return [resultArray autorelease];
}
*/

-(void) selectItemTarget:(FDCreature *)creature IncludeSelf:(BOOL)includeSelf
{
	CGPoint pos = [self getObjectPos:creature];
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	[array addObject:[FDPosition positionX:pos.x-1 Y:pos.y]];
	[array addObject:[FDPosition positionX:pos.x Y:pos.y-1]];
	[array addObject:[FDPosition positionX:pos.x+1 Y:pos.y]];
	[array addObject:[FDPosition positionX:pos.x Y:pos.y+1]];
	if (includeSelf) {
		[array addObject:[FDPosition positionX:pos.x Y:pos.y]];
	}
	
	for(FDPosition *pos in array)
	{
		FDScopeIndicator *indicator = [[FDScopeIndicator alloc] init];
		
		[self addObject:indicator Position:[pos posValue]];
		[indicator release];
	}
	[array release];
}


-(void) startNewTurn
{
	for (FDFriend *creature in friendList) {
		[creature startTurn];
	}
	
	for (FDEnemy *creature in enemyList) {
		[creature startTurn];
	}
}

/*
-(void) selectActionTarget:(int)actionId For:(FDCreature *)creature
{
}
*/
-(void) cancelMove:(FDFriend *)creature
{
	[self closeMenu];
	
	CGPoint lastPos = [creature getLastPosition];
	
	[creature setLocation:[self convertPosToLoc:lastPos]];
	[creature setGestureStatus:GestureStatus_Idle];
	
	[self setCursorTo:lastPos];
	[self prepareToMove:creature];
}

-(void) moveCursor:(int)direction	// 0:left 1:up 2:right 3:down
{
}

-(void) setCursorObjTo:(FDPosition *)pos
{
	[self setCursorTo:[pos posValue]];
}

-(void) setCursorToObject:(FDBattleObject *)obj
{
	if (obj == nil) {
		return;
	}
	
	CGPoint loc = [self getObjectPos:obj];
	
	if (loc.x > 0 && loc.x <= fieldWidth && loc.y > 0 && loc.y <= fieldHeight) {
		[self setCursorTo:loc];
	}
}

-(void) setCursorSize:(int)size {
    if (cursor != nil) {
        [cursor setSize:size];
    }
}

-(void) setCursorTo:(CGPoint)pos
{
	CGPoint loc = [self convertPosToLoc:pos];
	[cursor setLocation:loc];
	
	cursorPoint = pos;
	
	// Make sure cursor is in Screen
	CGPoint cursorScreenPos = [self getScreenLocationbyMap:loc];
	
	float minX = [Constants unitSize] * 2;
	float maxX = [FDWindow winSize].width - minX;
	float minY = [Constants unitSize] * 2;
	float maxY = [FDWindow winSize].height - minY;
	
	float dx = 0;
	if (cursorScreenPos.x < minX) {
		dx = minX - cursorScreenPos.x;
	}
	if (cursorScreenPos.x > maxX) {
		dx = maxX - cursorScreenPos.x;
	}
	
	float dy = 0;
	if (cursorScreenPos.y < minY) {
		dy = minY - cursorScreenPos.y;
	}
	if (cursorScreenPos.y > maxY) {
		dy = maxY - cursorScreenPos.y;
	}
	
	if (dx != 0 || dy != 0) {
		NSLog(@"Set Cursor, dx=%f, dy=%f", dx, dy);
	}
	
	CGPoint mapLoc = [self getMapLocation];
	[self setMapLocation:CGPointMake(mapLoc.x + dx, mapLoc.y + dy)];
    
    // Notify to Update the side bar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LayerUpdateSideBar" object:self];
}

-(CGPoint) getCursorPos
{
	return [self getObjectPos:cursor];
	// return cursorPoint;
}

-(int) getBackgroundPicId:(CGPoint)pos
{
	return fieldChapterId;
	// return [groundField fightBackgroundIdAtX:pos.x Y:pos.y];
}

-(int) getChapterId {
    return fieldChapterId;
}

-(NSMutableArray *) getObjectsByPos:(CGPoint)pos
{
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (FDBattleObject *obj in battleObjectList) {
		if ([FDPosition isEqual:[self getObjectPos:obj] With:pos])
		{
			[array addObject:obj];
		}
	}
	
	return [array autorelease];	
}

-(FDCreature *) getCreatureById:(int)iden
{
	for (FDBattleObject *obj in battleObjectList)
	{
		if ([obj isKindOfClass:[FDCreature class]])
		{
			FDCreature *cre = (FDCreature *)obj;
			if ([cre getIdentifier] == iden) {
				return cre;
			}
		}
	}
	return nil;
}

-(FDCreature *) getDeadCreatureById:(int)iden
{
	for (FDCreature *cre in deadCreatureList)
	{
		if ([cre getIdentifier] == iden) {
				return cre;
		}
	}
	return nil;
}

-(FDCreature *) getUnsettledCreatureById:(int)iden
{
    if (unsettledCreatureList == nil) {
        return nil;
    }
    
	for (FDCreature *cre in unsettledCreatureList)
	{
		if ([cre getIdentifier] == iden) {
            return cre;
		}
	}
	return nil;
}

-(FDCreature *) getCreatureByPos:(CGPoint)pos
{
	// Suppose one position show contain only one creature
	for (FDBattleObject *obj in [self getObjectsByPos:pos]) {
		if ([obj isKindOfClass:[FDCreature class]])
		{
			return (FDCreature *)obj;
		}
	}
	return nil;
}

-(FDMenuItem *) getMenuItemByPos:(CGPoint)pos
{
	// Suppose one position show contain only one menu item
	for (FDBattleObject *obj in [self getObjectsByPos:pos]) {
		if ([obj isKindOfClass:[FDMenuItem class]])
		{
			return (FDMenuItem *)obj;
		}
	}
	return nil;
}

-(FDCreature *) getCreatureThatCarriesItem:(int)itemId
{
    for (FDCreature *cre in friendList)
	{
		if ([cre.data hasItem:itemId]) {
            return cre;
		}
	}
    
    for (FDCreature *cre in deadCreatureList)
	{
		if ([cre.data hasItem:itemId]) {
            return cre;
		}
	}
    
    return nil;
}

-(BOOL) isInScope:(CGPoint)pos
{
	for (FDBattleObject *obj in battleObjectList) {
		if ([obj isKindOfClass:[FDScopeIndicator class]]
			&& [FDPosition isEqual:[self getObjectPos:obj] With:pos])
		{
			return TRUE;
		}
	}
	
	return FALSE;
}

-(CGSize) mapSize
{
	return CGSizeMake(fieldWidth, fieldHeight);
}

-(CGPoint) getMapLocation
{
	return [groundImage location];
}

-(void) setMapLocation:(CGPoint)loc
{
	float locX;
	float locY;
	locX = [Common minBetween:loc.x and:([groundImage size].width/2 + [Constants unitSize]*2)];
	locY = [Common minBetween:loc.y and:([groundImage size].height/2 + [Constants unitSize]*2)];
	
	locX = [Common maxBetween:locX and:([FDWindow winSize].width -[groundImage size].width/2 - [Constants unitSize]*2)];
	locY = [Common maxBetween:locY and:([FDWindow winSize].height -[groundImage size].height/2 - [Constants unitSize]*2)];
	
	[groundImage setLocation:CGPointMake(locX, locY)];
}

-(CGPoint) getObjectPos:(FDBattleObject *)obj
{
	if (obj == nil) {
		return CGPointMake(0, 0);
	}
	return [self convertLocToPos:[obj getLocation]];
}

-(FDSprite *) getSprite
{
	return groundImage;
}

-(NSMutableArray *) getFriendList
{
	return friendList;
	
}

-(NSMutableArray *) getEnemyList
{
	return enemyList;
}

-(NSMutableArray *) getNpcList
{
	return npcList;
}

-(NSMutableArray *) getDeadCreatureList
{
	return deadCreatureList;
}

-(NSMutableArray *) getUnsettledCreatureList
{
	return unsettledCreatureList;
}

-(int) getCalculatedEnemyCount
{
    int calculatedCount = 0;
    for (FDCreature *c in enemyList) {
        if ([c getDefinition].identifier == 761) {
            continue;
        }
        calculatedCount ++;
    }
    return calculatedCount;
}

-(CreatureRecord *) generateCreatureRecord:(FDCreature *)creature
{
	CreatureRecord *record = [[CreatureRecord alloc] init];
	record.creatureId = [creature getIdentifier];
	record.definitionId = [[creature getDefinition] getId];
	record.creatureType = [creature getCreatureType];
	
	record.data = [creature.data clone];
	record.location = [self getObjectPos:creature];
	
	return [record autorelease];
}

-(TreasureRecord *) generateTreasureRecord:(FDTreasure *)treasure
{
	TreasureRecord *record = [[TreasureRecord alloc] init];
	record.treasureType = [treasure treasureType];
	record.itemId = [treasure itemId];
	record.hasOpened = [treasure hasOpened];
	record.location = [self getObjectPos:treasure];
	
	return [record autorelease];
}


////////////////// END IFieldActionable ///////////////////

-(NSMutableArray *) searchActionScope:(CGPoint)pos Range:(FDRange *)range
{
	if (range == nil) {
		return nil;
	}
	
	// Build Map
	FDIntMap *map = [[FDIntMap alloc] initWidth:fieldWidth Height:fieldHeight];
	
	for (int i = 1; i <= fieldWidth; i++) {
		for (int j = 1; j <= fieldHeight; j++) {
			[map setX:i Y:j Value: ScopeResistance_Plain];
		}
	}
	
	ScopeResolver *resolver = [[ScopeResolver alloc] initWithMap:map Width:fieldWidth Height:fieldHeight];
	[map release];
	[resolver autorelease];
	
	return [resolver resolveScopeFrom:pos min:[range min] max:[range max]];
}

-(NSMutableArray *) searchMoveScope:(FDCreature *)creature
{
	CreatureType friendType1 = CreatureType_Friend;
	CreatureType friendType2 = CreatureType_Npc;
	// CreatureType enemyType1;
	// CreatureType enemyType2;
	
	if ([creature getCreatureType] == CreatureType_Friend || [creature getCreatureType] == CreatureType_Npc)
	{
		friendType1 = CreatureType_Friend;
		friendType2 = CreatureType_Npc;
		// enemyType1 = enemyType2 = CreatureType_Enemy;
	}
	
	if ([creature getCreatureType] == CreatureType_Enemy)
	{
		// enemyType1 = CreatureType_Friend;
		// enemyType2 = CreatureType_Npc;
		friendType1 = friendType2 = CreatureType_Enemy;
	}
	
	// Build Map
	FDIntMap *map = nil;
    if ([creature canFly]) {
        map = [[groundField getGroundScopeMapForFly] clone];
    } else if ([creature isKnight]) {
	    map = [[groundField getGroundScopeMapForKnight] clone];	
	} else if ([creature isMarshMonster]) {
	    map = [[groundField getGroundScopeMapForMarshMonster] clone];
	} else {
        map = [[groundField getGroundScopeMapForGround] clone];
    }
    
    [map retain];
    
	// Build by friends and enemies
	/*
	for (int i = 1; i <= fieldWidth; i++) {
		for (int j = 1; j <= fieldHeight; j++) {
			
			ScopeResistanceType resistance = ScopeResistance_Gap;
			
			ScopeResistanceType oldresistance = [map getX:i	Y:j];
			if (oldresistance == ScopeResistance_Gap) {
				continue;
			}
			
			FDCreature *c = [self getCreatureByPos:CGPointMake(i, j)];
			
			if (c == nil)
			{
				continue;
			}
			
			if ([c getCreatureType] == friendType1 || [c getCreatureType] == friendType2)
			{
				if (c == creature)
				{
					// NSLog(@"Got itself in search scope");
					resistance = ScopeResistance_Plain;
				}
				else
				{
					// NSLog(@"Got friend in search scope");
					resistance = ScopeResistance_Skip;
				}
			}
			
			[map setX:i Y:j Value: resistance];
		}
	}
	*/
	
	// Build ZOC
	for (int i = 1; i <= fieldWidth; i++) {
		for (int j = 1; j <= fieldHeight; j++) {
			
			ScopeResistanceType oldresistance = [map getX:i	Y:j];
			if (oldresistance == ScopeResistance_Gap) {
				continue;
			}
			
			FDCreature *c = [self getCreatureByPos:CGPointMake(i, j)];
			
			if (c == nil || [c getCreatureType] == friendType1 || [c getCreatureType] == friendType2)
			{
				continue;
			}
			
			// NSLog(@"Got enemy in search scope for ZOC");
			[map setX:i Y:j Value:ScopeResistance_Gap];
			
			// Set ZOC zone
			[self setScopeMapZOC:map X:i-1 Y:j];
			[self setScopeMapZOC:map X:i+1 Y:j];
			[self setScopeMapZOC:map X:i Y:j-1];
			[self setScopeMapZOC:map X:i Y:j+1];
		}
	}
	
	CGPoint pos = [self getObjectPos:creature];
	[map setX:pos.x Y:pos.y Value: ScopeResistance_Plain];
	
	ScopeResolver *resolver = [[ScopeResolver alloc] initWithMap:map Width:fieldWidth Height:fieldHeight];
	NSMutableArray *resultArray = [resolver resolveScopeFrom:[self getObjectPos:creature] min:0 max:creature.data.mv];
	[resultArray retain];
	[resolver release];
	[map release];
	
	// Remove all of the Scopes that Already Occupied
	int i = 0;
	while (i < [resultArray count])
	{
		FDPosition *pos = [resultArray objectAtIndex:i];
		FDCreature *c = [self getCreatureByPos:[pos posValue]];
		
		if (c != nil && c != creature)
		{
			[resultArray removeObject:pos];
		}
		else
		{
			i++;
		}
	}
	
	return [resultArray autorelease];
}

-(void) setScopeMapZOC:(FDIntMap *)map X:(int)x Y:(int)y
{
	if (x <= 0 || x > fieldWidth || y <= 0 || y > fieldHeight)
	{
		return;
	}
	
	ScopeResistanceType pos1type = [map getX:x Y:y];
	if (pos1type != ScopeResistance_Gap) {
		//NSLog(@"Set ZOC: %d, %d", x, y);
		[map setX:x Y:y Value:ScopeResistance_ZOC];
	}
}

-(int) getDirectDistance:(FDCreature *)creature1 And:(FDCreature *)creature2
{
	if (creature1 == nil || creature2 == nil) {
		return 999;
	}
	
	CGPoint pos1 = [self getObjectPos:creature1];
	CGPoint pos2 = [self getObjectPos:creature2];
	
	return [self getDirectDistancePos:pos1 And:pos2];
}

-(int) getDirectDistancePos:(CGPoint)pos1 And:(CGPoint)pos2
{
	int dx = pos1.x - pos2.x;
	dx = (dx < 0) ? -dx : dx;
	
	int dy = pos1.y - pos2.y;
	dy = (dy < 0) ? -dy : dy;
	
	return dx + dy;
}

-(NSMutableArray *) getEnemyInAttackScope:(FDCreature *)creature
{
	Class enemyClass = [FDFriend class];
	
	if ([creature isKindOfClass:[FDFriend class]])
	{
		enemyClass = [FDEnemy class];
	}
	
	if ([creature isKindOfClass:[FDEnemy class]])
	{
		enemyClass = [FDFriend class];
	}
	
	NSMutableArray *result = [[NSMutableArray alloc] init];
	
	NSMutableArray *scopeList = [self searchActionScope:[self getObjectPos:creature] Range:[creature attackRange]];
	if (scopeList == nil) {
		return [result autorelease];
	}
	
	for (FDPosition *pos in scopeList) {
		FDCreature *target = [self getCreatureByPos:[pos posValue]];
		if ([target isKindOfClass:enemyClass]) {
			[result addObject:target];
		}
	}
	
	return [result autorelease];
}

-(BOOL) isNextTo:(FDCreature *)creature1 And:(FDCreature *)creature2
{
	CGPoint pos1 = [self getObjectPos:creature1];
	CGPoint pos2 = [self getObjectPos:creature2];
	
	return ((abs(pos1.x-pos2.x) == 1 && pos1.y == pos2.y)
			|| (abs(pos1.y-pos2.y) == 1 && pos1.x == pos2.x));
}

-(BOOL) canLandedAt:(CGPoint)position forCreature:(FDCreature *)targetCreature
{
    if ([self getCreatureByPos:position] != nil)
    {
        return NO;
    }
    
    GroundBlock *block = [groundField blockAtX:position.x Y:position.y];
    
    if ([block getBlockType] == GroundBlockTypeGap
        || ([block getBlockType] == GroundBlockTypeChasm && ![targetCreature canFly]))
    {
        return NO;
    }
    
    return YES;
}

-(NSMutableArray *) getNearByFriend:(FDCreature *)creature
{
	Class friendClass = [FDEnemy class];	
	if ([creature isKindOfClass:[FDFriend class]])
	{
		friendClass = [FDFriend class];
	}
	
	if ([creature isKindOfClass:[FDEnemy class]])
	{
		friendClass = [FDEnemy class];
	}
	
	CGPoint pos = [self getObjectPos:creature];
	CGPoint positions[4];
	positions[0] = CGPointMake(pos.x-1, pos.y);
	positions[1] = CGPointMake(pos.x, pos.y-1);
	positions[2] = CGPointMake(pos.x+1, pos.y);
	positions[3] = CGPointMake(pos.x, pos.y+1);
	
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (int i = 0; i < 4; i ++) {
		FDCreature *c = [self getCreatureByPos: positions[i]];
		if ([c isKindOfClass:friendClass]) {
			[result addObject:c];
		}
	}
	return [result autorelease];
}

-(FDTreasure *) getTreasureAt:(CGPoint)pos
{
	for (FDBattleObject *obj in battleObjectList) {
		
		if ([obj isKindOfClass:[FDTreasure class]] && [FDPosition isEqual:pos With:[self getObjectPos:obj]]) {
			return (FDTreasure *)obj;
		}
	}
	return nil;
}

-(NSMutableArray *) getTreasureList
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (FDBattleObject *obj in battleObjectList) {
		
		if ([obj isKindOfClass:[FDTreasure class]]) {
			[result addObject:(FDTreasure *)obj];
		}
	}
	return [result autorelease];
}

-(NSMutableArray *) getCreaturesAt:(CGPoint)position Range:(int)ran BadGuys:(BOOL)areGadGuys
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	
	FDRange *range = [[FDRange alloc] initWithMin:0 Max:ran];
	NSMutableArray *scopeList = [self searchActionScope:position Range:range];
	
	for(FDPosition *pos in scopeList)
	{
		FDCreature *c = [self getCreatureByPos:[pos posValue]];
		if (c == nil) {
			continue;
		}
		if ((areGadGuys && [c getCreatureType] == CreatureType_Enemy)
		|| (!areGadGuys && ([c getCreatureType] == CreatureType_Friend ||[c getCreatureType] == CreatureType_Npc))
			 ) {
			[result addObject:c];
		}
	}

	[range release];
	return [result autorelease];
}

-(void) showTestData
{
	for (FDBattleObject *obj in battleObjectList) {
		
		CGPoint pos1 = [self getObjectPos:obj];
		NSLog(@"Object Identifier: %@ (%f, %f)", [obj class], pos1.x, pos1.y);
		
	}
	
}

-(void) dealloc
{
	[groundImage release];
	[groundField release];
	
	[battleObjectList release];
	[friendList release];
	
	[cursor release];
	
	[super dealloc];
}


@end
