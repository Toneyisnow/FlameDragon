//
//  FDBattleObject.h
//  FlameDragon
//
//  Created by sui toney on 11-11-5.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDDrawable.h"

typedef enum BattleObjectOrder
{
	BattleObjectOrder_OnGround = 1,
	BattleObjectOrder_Indicator = 2,
	BattleObjectOrder_Creature = 3,
	BattleObjectOrder_Menu = 4,
	BattleObjectOrder_FocusCreature = 5
} BattleObjectOrder; 

@interface FDBattleObject : FDDrawable {

	bool isDeprecated;
	
	int zOrder;
}

-(void) takeTick:(int)synchronizedTick;


-(void) setLocation:(CGPoint)loc;
-(CGPoint) getLocation;

-(int) zOrder;
-(void) changeZOrder:(BattleObjectOrder)zorder;


@end
