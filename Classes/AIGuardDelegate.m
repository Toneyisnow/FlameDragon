//
//  AIGuardDelegate.m
//  FlameDragon
//
//  Created by sui toney on 13-4-27.
//
//

#import "AIGuardDelegate.h"
#import "Common.h"

@implementation AIGuardDelegate

-(id) initWithCreature:(FDCreature *)c Layers:(ActionLayers *)l {
    self = [super initWithCreature:c Layers:l];
    return self;
}

-(void) takeAction
{
	CCLOG(@"AIGuardDelegate take action on creature %d", [creature getIdentifier]);
	
	BattleField *field = [[layers getFieldLayer] getField];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if ([creature getCreatureType] == CreatureType_Enemy) {
        [arr addObjectsFromArray:[field getFriendList]];
        [arr addObjectsFromArray:[field getNpcList]];
    } else {
        [arr addObjectsFromArray:[field getEnemyList]];
    }
    
    BOOL guardHoldPosition = YES;
    for (FDCreature *c in arr) {
        if ([field getDirectDistance:creature And:c] <= 5) {
            guardHoldPosition = NO;
            break;
        }
    }
    
    [arr release];
    
    if (guardHoldPosition) {
        [layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];
    } else {
        [super takeAction];
    }
    
}

@end
