//
//  FDTreasure.h
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDBattleObject.h"
#import "ItemDefinition.h"

typedef enum TreasureType
{
	TreasureType_Red = 1,
	TreasureType_Blue = 2,
	TreasureType_Hidden = 3
} TreasureType;

@interface FDTreasure : FDBattleObject {

	BOOL hasOpened;
	TreasureType type;
	int itemId;
}

+(id) treasureWithType:(TreasureType)t Item:(int)i;

-(id) initWithType:(TreasureType)t Item:(int)i;

-(BOOL) hasOpened;
-(void) setOpened;

-(TreasureType) treasureType;

-(ItemDefinition *) getItem;
-(int) itemId;

-(void) changeItemId:(int)it;

@end
