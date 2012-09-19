//
//  AIEscapeDelegate.m
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "AIEscapeDelegate.h"


@implementation AIEscapeDelegate

@synthesize escapePosition;

-(id) initWithCreature:(FDCreature *)c Layers:(ActionLayers *)l
{
	self = [super initWithCreature:c Layers:l];
	
	self.escapePosition = [[FDPosition alloc] initX:0 Y:0];
	
	return self;
}

-(void) takeAction
{
	NSLog(@"AIEscapeDelegate take action on creature %d", [creature getIdentifier]);
	NSLog(@"Escape to point :(%d, %d)", [escapePosition posValue].x, [escapePosition posValue].y);
	
	BattleField *field = [[layers getFieldLayer] getField];
	CGPoint targetPos = [self generatePos:[escapePosition posValue]];
	
	[field setCursorTo:targetPos];
	[layers moveCreature:creature To:targetPos showMenu:FALSE];
	
	[layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];
}

-(void) setParameter:(id)param
{
	NSLog(@"Parameter for EscapeDelegate is set.");
	self.escapePosition = (FDPosition *)param;
}

@end
