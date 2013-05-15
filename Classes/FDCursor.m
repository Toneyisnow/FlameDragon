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
    
    curSize = 1;
    [self setSprite: [[FDSpriteStore instance] sprite:@"Cursor-01.png"]];
	
    return self;
}

-(void) setSize:(int) size {
    curSize = size;
    
    NSString *fileName = [NSString stringWithFormat:@"Cursor-%02d.png",size];
    CCLOG(@"Set Cursor file = %@", fileName);
    
    FDImage *image = [[FDSpriteStore instance] image:fileName];
	[sprite setImage:image ChangeSize:YES];
}



@end
