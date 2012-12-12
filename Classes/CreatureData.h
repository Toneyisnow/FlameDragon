//
//  CreatureData.h
//  FlameDragon
//
//  Created by sui toney on 12-3-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "AttackItemDefinition.h"
#import "DefendItemDefinition.h"


typedef enum BodyStatus {
	BodyStatus_Normal,
	BodyStatus_Faster,
	BodyStatus_Poisoned,
	BodyStatus_Frozen,
	BodyStatus_Prohibitted
} BodyStatus;

typedef enum AIType {
	AIType_Aggressive,
	AIType_Escape,
	AIType_StandBy
} AIType;

//
// All properties in this class should be a changable value during the game
//
@interface CreatureData : NSObject<NSCoding> {

	int level;
	
	int hpMax;
	int mpMax;
	int hpCurrent;
	int mpCurrent;
	
	int ap;
	int dp;
	int dx;
	int mv;
	
	int ex;
	//int baseExp;
	
	//FDRange *attackRange;
	
	
	NSMutableArray *magicList;
	NSMutableArray *itemList;
	
	// BodyStatus bodyStatus;
	BOOL statusEnhanceAp;
	BOOL statusEnhanceDp;
	BOOL statusEnhanceDx;
	BOOL statusPoisoned;
	BOOL statusFrozen;
	BOOL statusProhibited;
	
	
	AIType aiType;
	id aiParam;
	
	int attackItemIndex;
	int defendItemIndex;
}

-(CreatureData *) clone;

+(int) ITEM_MAX;
+(int) MAGIC_MAX;

// Calculated Values
-(int) calculatedHit;
-(int) calculatedEv;
-(int) calculatedAp;
-(int) calculatedDp;
-(int) hitWithItem:(int)itemId;
-(int) evWithItem:(int)itemId;
-(int) apWithItem:(int)itemId;
-(int) dpWithItem:(int)itemId;

-(void) removeItem:(int)index;

-(void) clearAllStatus;
-(void) recoverHealth;

-(AttackItemDefinition *) getAttackItem;
-(DefendItemDefinition *) getDefendItem;

@property (nonatomic,retain) NSMutableArray *magicList;
@property (nonatomic,retain) NSMutableArray *itemList;

@property (nonatomic) int level;
@property (nonatomic) int ap;
@property (nonatomic) int dp;
@property (nonatomic) int dx;
@property (nonatomic) int mv;
@property (nonatomic) int ex;
//@property (nonatomic) int baseExp;
@property (nonatomic) int hpCurrent;
@property (nonatomic) int mpCurrent;
@property (nonatomic) int hpMax;
@property (nonatomic) int mpMax;

@property (nonatomic) BOOL statusEnhanceAp;
@property (nonatomic) BOOL statusEnhanceDp;
@property (nonatomic) BOOL statusEnhanceDx;
@property (nonatomic) BOOL statusPoisoned;
@property (nonatomic) BOOL statusFrozen;
@property (nonatomic) BOOL statusProhibited;


@property (nonatomic) int attackItemIndex;
@property (nonatomic) int defendItemIndex;

@property (nonatomic) AIType aiType;
@property (retain, nonatomic) id aiParam;

@property (nonatomic) BodyStatus bodyStatus;

@end
