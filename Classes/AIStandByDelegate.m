//
//  AIStandByDelegate.m
//  FlameDragon
//
//  Created by sui toney on 12-12-9.
//  Copyright 2012 ms. All rights reserved.
//

#import "AIStandByDelegate.h"


@implementation AIStandByDelegate

-(id) initWithCreature:(FDCreature *)c Layers:(ActionLayers *)l
{
	self = [super initWithCreature:c Layers:l];
	
	return self;
}

-(void) takeAction
{
	NSLog(@"AIStandByDelegate take action on creature %d", [creature getIdentifier]);
	
	[layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];	
}

@end
