//
//  FDTransparencyFrameDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-11-5.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDTransparencyFrameDefinition.h"


@implementation FDTransparencyFrameDefinition


-(id) initWithOpacity:(int)o Time:(int)t
{
	self = [super initWithTime:t];
	
	opacity = o;
	
	return self;
}

+(id) frameWithOpaticy:(int)o Time:(int)t
{
    FDTransparencyFrameDefinition *frame = [[FDTransparencyFrameDefinition alloc] initWithOpacity:o Time:t];
    
    return [frame autorelease];
}

-(void) renderFrame:(FDSprite *)sprite
{
	[sprite setOpacity:opacity];
}

@end
