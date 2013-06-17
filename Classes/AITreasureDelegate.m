//
//  AITreasureDelegate.m
//  FlameDragon
//
//  Created by sui toney on 13-6-17.
//
//

#import "AITreasureDelegate.h"
#import "AITreasureParam.h"

@implementation AITreasureDelegate

-(id) initWithCreature:(FDCreature *)c Layers:(ActionLayers *)l
{
	self = [super initWithCreature:c Layers:l];
	
	//[self initDistanceResolver:c];
    treasurePosition = CGPointMake(0, 0);
    escapePosition = CGPointMake(0, 0);
    
	return self;
}

-(void) takeAction
{
	CCLOG(@"AITreasureDelegate take action on creature %d", [creature getIdentifier]);
    BattleField *field = [[layers getFieldLayer] getField];
	
    FDTreasure *treasure = [field getTreasureAt:treasurePosition];
    
    CGPoint headingPosition;
    if (treasure != nil && ![treasure hasOpened])
    {
        CCLOG(@"Heading to treasure point: (%f, %f)", treasurePosition.x, treasurePosition.y);
        headingPosition = treasurePosition;
    }
    else
    {
        CCLOG(@"Heading to escape point: (%f, %f)", escapePosition.x, escapePosition.y);
        headingPosition= escapePosition;
    }
	
    CGPoint targetPos = [self generatePos:headingPosition];
	[field setCursorTo:targetPos];
	[layers moveCreature:creature To:targetPos showMenu:FALSE];
	
    [layers appendToCurrentActivityMethod:@selector(checkEndTurnCondition) Param1:creature Param2:nil Obj:self];
}

-(void) checkEndTurnCondition
{
    CCLOG(@"Check End Turn Condition.");
    BattleField *field = [[layers getFieldLayer] getField];
	
    if ([FDPosition isEqual:[field getObjectPos:creature] With:treasurePosition]) {
        //Pick up the treasure
        [layers pickUpTreasure:creature];
    }
    
    [layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];
}

-(void) setParameter:(id)param
{
    if (![param isKindOfClass:[AITreasureParam class]]) {
        CCLOG(@"Error in setParameter: param is not kind of AITreasureParam.");
        return;
    }
    
    treasurePosition = [(AITreasureParam *)param getTreasurePosition];
	escapePosition = [(AITreasureParam *)param getEscapePosition];
	
	CCLOG(@"Parameter for TreasureDelegate is set. ");
    CCLOG(@"Treasure=[%f, %f]", treasurePosition.x, treasurePosition.y);
	CCLOG(@"Escape=[%f, %f]", escapePosition.x, escapePosition.y);
}

@end
