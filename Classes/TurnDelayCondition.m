//
//  TurnDelayCondition.m
//  FlameDragon
//
//  Created by sui toney on 13-9-11.
//
//

#import "TurnDelayCondition.h"
#import "BattleField.h"

@implementation TurnDelayCondition


-(id) initWithTurnType:(TurnType)type DelayCount:(int)n
{
	self = [super init];
	
	turnType = type;
	turnNumber = n;
	
	return self;
}

-(BOOL) isMatch:(ActionLayers *)layers
{
    if ([layers getExtraInfo] == 0) {
        return FALSE;
    }
    
	// This must be triggered after the turn
	
	BattleField *field = [[layers getFieldLayer] getField];
	
	NSMutableArray *creatureList;
	switch (turnType) {
		case TurnType_Friend:
			creatureList = [field getFriendList];
			break;
		case TurnType_NPC:
			creatureList = [field getNpcList];
			break;
		case TurnType_Enemy:
			creatureList = [field getEnemyList];
			break;
		default:
			break;
	}
	
	for (FDCreature *creature in creatureList)
	{
		if(![creature hasActioned])
		{
			return FALSE;
		}
	}
	
    int turnsCount = [layers getTurnNumber] - [layers getExtraInfo];
	return ([layers getTurnType] == turnType && turnsCount >= turnNumber);
}

@end
