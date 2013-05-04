//
//  FDCreature.m
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDCreature.h"
#import "DataDepot.h"
#import "FDRange.h"
#import "FDRandom.h"
#import "FDLocalString.h"
#import "FDSlideAnimation.h"
#import "FDSyncedAnimation.h"
#import "AnimationDefinition.h"
#import "FDSpriteStore.h"
#import "AttackItemDefinition.h"
#import "DefendItemDefinition.h"

@implementation FDCreature

@synthesize hasMoved,hasActioned,pendingAction;
@synthesize hpPrevious,mpPrevious;
@synthesize data;
@synthesize lastGainedExperience;

-(id) initWithAni:(int)aniId Id:(int)i
{
	self = [super init];
	
	creatureId = i;
	actionStatus = ActionStatus_Idle;
	
	currentAnimation = nil;
	zOrder = BattleObjectOrder_Creature;
	
	animationDefId = aniId;
	NSString *defaultSpriteFile = [NSString stringWithFormat:@"Icon-%03d-02.png", animationDefId];
	[self setSprite: [[FDSpriteStore instance] sprite:defaultSpriteFile]];
	
	return self;
}

-(id) initWithDefinition:(int)identity Id:(int)i
{
	return [self initWithDefinition:identity Id:i Data:nil];
}

-(id) initWithDefinition:(int)identity Id:(int)i Data:(CreatureData *)dat
{
	CreatureDefinition *def = [[DataDepot depot] getCreatureDefinition:identity];
	
	self = [self initWithAni:[def getAnimationId] Id:i];
	
	definition = def;
	
	if (dat == nil) {
		data = [[definition.data clone] retain];
	} else {
		data = [[dat clone] retain];
	}
	
	hpPrevious = data.hpCurrent;
	mpPrevious = data.mpCurrent;
	
	NSLog(@"Loaded Item List, Count=%d", [data.itemList count]);
	NSLog(@"Loaded Magic List, Count=%d", [data.magicList count]);
	
		
	// TODO: this should be updated
	//attackRange = [[FDRange alloc] initWithMin:1 Max:[definition attackRange]];
	
	if (data.attackItemIndex < 0 || data.defendItemIndex < 0)
	{
	for (int i = 0;i < [data.itemList count]; i++) {
		
		int itemId = [[data.itemList objectAtIndex:i] intValue];
		ItemDefinition *def = [[DataDepot depot] getItemDefinition:itemId];
		
		if (data.attackItemIndex < 0 && [def isKindOfClass:[AttackItemDefinition class]]) {
			data.attackItemIndex = i;
		}
		if (data.defendItemIndex < 0 && [def isKindOfClass:[DefendItemDefinition class]]) {
			data.defendItemIndex = i;
		}
	}
	}
	// By default the AI will be
	if (dat == nil) {
		data.aiType = AIType_Aggressive;
	}
	
	lastGainedExperience = 0;
	
	return self;
}


-(int) getIdentifier
{
	return creatureId;
}

-(CreatureDefinition *) getDefinition
{
	return definition;
}

-(void) setActionStatus:(ActionStatus) as
{
	actionStatus = as;
//	[self updateAnimation];
}

-(void) setGestureStatus:(GestureStatus) gs
{
	gestureStatus = gs;
	[self updateAnimation];
}

-(void) updateAnimation
{
	// NSLog(@"update Animation");
	
	if (currentAnimation != nil) {
		[currentAnimation release];
	}
	
	if (gestureStatus == GestureStatus_MovingUp) {
		AnimationDefinition *def = [[DataDepot depot] getAnimationDefinition:AnimationType_MovingUp Id:[definition getAnimationId]];
		currentAnimation = [[FDSlideAnimation alloc] initWithDefinition:def Sprite:sprite];
		
	}
	if (gestureStatus == GestureStatus_MovingDown) {
		AnimationDefinition *def = [[DataDepot depot] getAnimationDefinition:AnimationType_MovingDown Id:[definition getAnimationId]];
		currentAnimation = [[FDSlideAnimation alloc] initWithDefinition:def Sprite:sprite];
	}
	if (gestureStatus == GestureStatus_MovingLeft) {
		AnimationDefinition *def = [[DataDepot depot] getAnimationDefinition:AnimationType_MovingLeft Id:[definition getAnimationId]];
		currentAnimation = [[FDSlideAnimation alloc] initWithDefinition:def Sprite:sprite];
	}
	if (gestureStatus == GestureStatus_MovingRight) {
		AnimationDefinition *def = [[DataDepot depot] getAnimationDefinition:AnimationType_MovingRight Id:[definition getAnimationId]];
		currentAnimation = [[FDSlideAnimation alloc] initWithDefinition:def Sprite:sprite];
	}
	if (gestureStatus == GestureStatus_Idle) {
		AnimationDefinition *def = [[DataDepot depot] getAnimationDefinition:AnimationType_Idle Id:[definition getAnimationId]];
		currentAnimation = [[FDSyncedAnimation alloc] initWithDefinition:def Sprite:sprite];
	}
}

-(void) takeTick:(int)synchronizedTick
{
	//NSLog(@"Creature take tick.");
	if (actionStatus == ActionStatus_Dead) {
	
		// If dead, no need to have animation, the Die Activity will handle that
		return;
	}
	
	if (currentAnimation != nil) {
		[currentAnimation takeTick:synchronizedTick];
	}
	else {
		[self updateAnimation];
	}
}

-(void) preMove:(CGPoint)pos
{
	
}

-(void) postMove:(CGPoint)pos
{
}

-(int) updateHP:(int)delta
{
	hpPrevious = data.hpCurrent;
	
	data.hpCurrent += delta;
	
	if (data.hpCurrent < 0) {
		data.hpCurrent = 0;
	}
	
	if (data.hpCurrent > data.hpMax) {
		data.hpCurrent = data.hpMax;
	}
	
	return data.hpCurrent - hpPrevious;
}

-(int) updateMP:(int)delta
{
	mpPrevious = data.mpCurrent;
	
	data.mpCurrent += delta;
	
	if (data.mpCurrent < 0) {
		data.mpCurrent = 0;
	}
	
	if (data.mpCurrent > data.mpMax) {
		data.mpCurrent = data.mpMax;
	}
	
	return data.mpCurrent - mpPrevious;
}

-(NSString *) updateExpAndLevelUp
{
	data.ex += lastGainedExperience;
	lastGainedExperience = 0;

	BOOL levelUp = (data.ex >= 100) && (data.level < [definition getMaximumLevel]);
	
	if (levelUp) {
		
		// Level Up
		return [self levelUp];
	}
	else {
		return nil;
	}
}

-(NSString *) levelUp
{
	data.ex -= 100;
	data.ex = (data.ex < 0) ? 0 : data.ex;
	
	data.level += 1;
	
	LevelUpDefinition *levelUp = [[DataDepot depot] getLevelUpDefinition:[definition getId]];
	
	int hpInc = [FDRandom fromRange:levelUp.hpRange];
	int mpInc = [FDRandom fromRange:levelUp.mpRange];
	int apInc = [FDRandom fromRange:levelUp.apRange];
	int dpInc = [FDRandom fromRange:levelUp.dpRange];
	int dxInc = [FDRandom fromRange:levelUp.dxRange];
	MagicDefinition *magic = [[DataDepot depot] getLevelUpMagicDefinition:[definition getId] atLeveL:data.level];
	
	data.hpMax += hpInc;
	data.mpMax += mpInc;
	data.ap += apInc;
	data.dp += dpInc;
	data.dx += dxInc;
	if (magic != nil) {
        [data addMagic:magic.identifier];
	}
    
    // Fix bug: If there is some magic from previous levels missing, add them
    for (int level = 1; level < data.level; level++) {
        MagicDefinition *m = [[DataDepot depot] getLevelUpMagicDefinition:[definition getId] atLeveL:level];
        if (m != nil) {
            [data addMagic:m.identifier];
        }
    }
	
	// NSString *message = [NSString stringWithFormat:@"等级上升了！#攻击力提升5#防御力提升3#速度提升4#"];
	
	NSString *msg0 = [FDLocalString message:11];
	NSString *msgHp = (hpInc > 0) ? [NSString stringWithFormat:[FDLocalString message:12], hpInc] : @"";
	NSString *msgMp = (mpInc > 0) ? [NSString stringWithFormat:[FDLocalString message:13], mpInc] : @"";
	NSString *msgAp = (apInc > 0) ? [NSString stringWithFormat:[FDLocalString message:14], apInc] : @"";
	NSString *msgDp = (dpInc > 0) ? [NSString stringWithFormat:[FDLocalString message:15], dpInc] : @"";
	NSString *msgDx = (dxInc > 0) ? [NSString stringWithFormat:[FDLocalString message:16], dxInc] : @"";
	NSString *msgMagic = (magic != nil) ? [NSString stringWithFormat:[FDLocalString message:17], magic.name] : @"";
	
	NSString *message = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", msg0, msgHp, msgMp, msgAp, msgDp, msgDx, msgMagic];
	
	return message;
}

-(void) startTurn
{
	hasActioned = FALSE;
	hasMoved = FALSE;
	pendingAction = FALSE;
	
	[sprite setColorR:255 G:255 B:255];
}

-(void) endTurn
{
	if (!hasActioned) {
		hasActioned = TRUE;
		pendingAction = FALSE;
	}
	
	[sprite setColorR:127 G:127 B:127];
}

-(void) pendAction
{
	pendingAction = TRUE;
	
	[sprite setColorR:255 G:255 B:255];	
}

-(int) getMagicId:(int) index
{
	if (index > [data.magicList count] - 1) {
		return 0;
	}
	
	return [[data.magicList objectAtIndex:index] intValue];
}

-(int) getItemId:(int) index
{
	if (index < 0 || index >= [data.itemList count]) {
		return 0;
	}
	
	return [[data.itemList objectAtIndex:index] intValue];	
}

-(BOOL) canAttack
{
	if ([self getItemId:data.attackItemIndex] > 0) {
		return TRUE;
	}
	
	return FALSE;
}

-(BOOL) canFightBack
{
	int itemId = [self getItemId:data.attackItemIndex];
	
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:itemId];
	
	if (item != nil && [item isKindOfClass:[AttackItemDefinition class]]) {
		AttackItemDefinition *aItem = (AttackItemDefinition *)item;
		return [self canAttack] && (aItem.itemCategory != 4);
	}
	
	return FALSE;
}

-(BOOL) isAbleToAttack:(FDCreature *)another
{
	if (another == nil) {
		return FALSE;
	}
	return (self.data.attackItemIndex >= 0) 
		&& [self.data calculatedAp] > [another.data calculatedDp]
		&& another.data.aiType != AIType_UnNoticable;
}

-(BOOL) isItemListFull
{
	return [data.itemList count] >= 8;
}


/*
-(void) removeItem:(int)index
{
	if (index >= [data.itemList count]) {
		NSLog(@"Cannot remove item, the index %d is out of range (count=%d)", index, [data.itemList count]);
	}
	[data.itemList removeObjectAtIndex:index];
	
	if (data.attackItemIndex == index) {
		data.attackItemIndex = -1;
	}
	if (data.attackItemIndex > index) {
		data.attackItemIndex --;
	}
	if (data.defendItemIndex == index) {
		data.defendItemIndex = -1;
	}
	if (data.defendItemIndex > index) {
		data.defendItemIndex --;
	}
}
*/
-(void) addItem:(int)itemId
{
	[data.itemList addObject:[NSNumber numberWithInt:itemId]];
}

-(void) equipEquipment:(int) index
{
	NSLog(@"Equip equipment %d", index);
	
	if (index >= [data.itemList count]) {
		return;
	}
	
	int itemId = [[data.itemList objectAtIndex:index] intValue];
	
	if (![definition canEquip:itemId]) {
		// Cannot Equip this item
		return;
	}
	
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:itemId];
	if ([item isKindOfClass:[AttackItemDefinition class]]) {
		data.attackItemIndex = index;
	}
	if ([item isKindOfClass:[DefendItemDefinition class]]) {
		data.defendItemIndex = index;
	}
}

-(void) dropItem:(int) index
{
	NSLog(@"Drop Item %d", index);
	
	
	[data removeItem:index];
}

-(NSString *) getName
{
	return definition.name;
}

-(CreatureType) getCreatureType
{
	return creatureType;
}

-(FDRange *)attackRange
{
	if (data.attackItemIndex < 0) {
		return nil;
	}
	
	NSNumber *itemId = [[data itemList] objectAtIndex:data.attackItemIndex];
	ItemDefinition *attackItem = [[DataDepot depot] getItemDefinition:[itemId intValue]];
	
	if (attackItem != nil && [attackItem isAttackItem]) {
		return ((AttackItemDefinition *)attackItem).attackRange;
	} else {
		return nil;
	}

}

-(void) setLastGainedExperience:(int)exp
{
	lastGainedExperience = (exp > 99) ? 99 : exp;
}

-(BOOL) canFireMagic
{
	return ([data.magicList count] > 0) && !hasMoved && (data.statusProhibited <= 0);
}

-(BOOL) canFly {
    	return [definition canFly];
}

-(BOOL) isNotFrozen {
    	return data.statusFrozen <= 0;
}

-(BOOL) isKnight {
	return [definition isKnight];
}

-(BOOL) isMarshMonster {
	return [definition isMarshMonster];
}

-(BOOL) isNoticable {
	return data.aiType != AIType_UnNoticable;
}

-(void) wokeUpByAttack {
	
	if (data.aiType == AIType_StandBy) {
		data.aiType = AIType_Aggressive;
	}
}

-(void) dealloc
{
	[data release];
	
	//[animationDefinition release];
	[currentAnimation release];
	
	[super dealloc];
}

@end
