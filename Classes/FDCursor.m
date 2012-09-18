//
//  FDCursor.m
//  FlameDragon
//
//  Created by sui toney on 11-12-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDCursor.h"
#import "FDSpriteStore.h"

@implementation FDCursor

-(id) init 
{
	self = [super init];
	
	zOrder = BattleObjectOrder_Indicator;
	
	[self setSprite: [[FDSpriteStore instance] sprite:@"Cursor.png"]];
	
	return self;
}



@end
