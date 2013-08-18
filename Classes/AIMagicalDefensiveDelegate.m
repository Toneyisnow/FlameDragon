//
//  AIMagicalDefensiveDelegate.m
//  FlameDragon
//
//  Created by sui toney on 13-8-17.
//
//

#import "AIMagicalDefensiveDelegate.h"

@implementation AIMagicalDefensiveDelegate

-(id) initWithCreature:(FDCreature *)c Layers:(ActionLayers *)l
{
	self = [super initWithCreature:c Layers:l];
	return self;
}

-(void) takePendAction
{
	CCLOG(@"takePendAction");
    
    // Hold Position
    [layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];
}

@end
