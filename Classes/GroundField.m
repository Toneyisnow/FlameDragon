//
//  GroundField.m
//  FlameDragon
//
//  Created by sui toney on 11-11-9.
//  Copyright 2011 ms. All rights reserved.
//

#import "GroundField.h"
#import "FDRect.h"
#import "PathResolver.h"

@implementation GroundField


-(id) initWithDefinitionStream:(FDFileStream *)fileStream
{
	self = [super init];
	
	if (fileStream == nil) {
		NSLog(@"Initialize GroundField failed: File Stream is nil.");
		return nil;
	}
	
	blockList = [[NSMutableArray alloc] init];
	
	int width = [fileStream readInt];
	int height = [fileStream readInt];
	fieldSize = CGSizeMake(width, height);
	
    groundPathMapForGround = [[FDIntMap alloc] initWidth:fieldSize.width Height:fieldSize.height];
	groundPathMapForFly = [[FDIntMap alloc] initWidth:fieldSize.width Height:fieldSize.height];
	groundScopeMapForGround = [[FDIntMap alloc] initWidth:fieldSize.width Height:fieldSize.height];
	groundScopeMapForFly = [[FDIntMap alloc] initWidth:fieldSize.width Height:fieldSize.height];
	groundScopeMapForKnight = [[FDIntMap alloc] initWidth:fieldSize.width Height:fieldSize.height];
	
	for (int j = 1; j <= fieldSize.height; j++) {
		for (int i = 1; i <= fieldSize.width; i++) {
				
			GroundBlockType type = [fileStream readInt];
			GroundBlock *block = [GroundBlock blockWithType: type];
			[blockList addObject:block];
            
			
            switch ([block getBlockType])
			{
				case GroundBlockTypeGround:
					[groundPathMapForGround setX:i Y:j Value: PathBlockType_Plain];
					[groundPathMapForFly setX:i Y:j Value: PathBlockType_Plain];
					[groundScopeMapForGround setX:i Y:j Value: ScopeResistance_Plain];
					[groundScopeMapForFly setX:i Y:j Value: ScopeResistance_Plain];
					[groundScopeMapForKnight setX:i Y:j Value: ScopeResistance_Plain];
					break;
				case GroundBlockTypeChasm:
					[groundPathMapForGround setX:i Y:j Value: PathBlockType_Blocked];
					[groundPathMapForFly setX:i Y:j Value: PathBlockType_Plain];
					[groundScopeMapForGround setX:i Y:j Value: ScopeResistance_Gap];
					[groundScopeMapForFly setX:i Y:j Value: ScopeResistance_Plain];
					[groundScopeMapForKnight setX:i Y:j Value: ScopeResistance_Gap];
					break;
				case GroundBlockTypeMarsh:
					[groundPathMapForGround setX:i Y:j Value: PathBlockType_Blocked];
					[groundPathMapForFly setX:i Y:j Value: PathBlockType_Blocked];
					[groundScopeMapForGround setX:i Y:j Value: ScopeResistance_Slow];
					[groundScopeMapForFly setX:i Y:j Value: ScopeResistance_Plain];
					[groundScopeMapForKnight setX:i Y:j Value: ScopeResistance_VerySlow];
					break;
				case GroundBlockTypeGap:
					[groundPathMapForGround setX:i Y:j Value: PathBlockType_Blocked];
					[groundPathMapForFly setX:i Y:j Value: PathBlockType_Blocked];
					[groundScopeMapForGround setX:i Y:j Value: ScopeResistance_Gap];
					[groundScopeMapForFly setX:i Y:j Value: ScopeResistance_Gap];
					[groundScopeMapForKnight setX:i Y:j Value: ScopeResistance_Gap];
					break;
				case GroundBlockTypeForest:
					[groundPathMapForGround setX:i Y:j Value: PathBlockType_Plain];
					[groundPathMapForFly setX:i Y:j Value: PathBlockType_Plain];
					[groundScopeMapForGround setX:i Y:j Value: ScopeResistance_Plain];
					[groundScopeMapForFly setX:i Y:j Value: ScopeResistance_Plain];
					[groundScopeMapForKnight setX:i Y:j Value: ScopeResistance_Slow];
					break;
				case GroundBlockTypeBlackForest:
					[groundPathMapForGround setX:i Y:j Value: PathBlockType_Plain];
					[groundPathMapForFly setX:i Y:j Value: PathBlockType_Plain];
					[groundScopeMapForGround setX:i Y:j Value: ScopeResistance_Plain];
					[groundScopeMapForFly setX:i Y:j Value: ScopeResistance_Plain];
					[groundScopeMapForKnight setX:i Y:j Value: ScopeResistance_Slow];
					break;
				default:
					[groundPathMapForGround setX:i Y:j Value: PathBlockType_Plain];
					[groundPathMapForFly setX:i Y:j Value: PathBlockType_Plain];
					[groundScopeMapForGround setX:i Y:j Value: ScopeResistance_Plain];
					[groundScopeMapForFly setX:i Y:j Value: ScopeResistance_Plain];
					[groundScopeMapForKnight setX:i Y:j Value: ScopeResistance_Plain];
					break;
			}
		}
	}
	
	// Load the background picture id
	
	backgroundDic = [[NSMutableDictionary alloc] init];
	
	FDRect *rect = [[FDRect alloc] initWithX:1 Y:1 Width:width Height:height];
	//CGRectMake(1, 1, width, height);
	[backgroundDic setObject:rect forKey:[NSNumber numberWithInt:1]];
	[rect release];
	
	NSLog(@"Ground Field Loaded. w=%d h=%d", width, height);
    
	return self;
}

-(FDIntMap *) getgroundPathMapForGround {
    return groundPathMapForGround;
}

-(FDIntMap *) getgroundPathMapForFly {
    return groundPathMapForFly;
}

-(FDIntMap *) getgroundScopeMapForGround {
    return groundScopeMapForGround;
}

-(FDIntMap *) getgroundScopeMapForFly {
    return groundScopeMapForFly;
}

-(FDIntMap *) getgroundScopeMapForKnight {
    return groundScopeMapForKnight;
}

-(CGSize) fieldSize
{
	return fieldSize;
}

-(GroundBlock *) blockAtX:(int)x Y:(int)y
{
	if (x <= 0 || x > fieldSize.width || y <= 0 || y > fieldSize.height) {
		return nil;
	}
	
	return [blockList objectAtIndex:(y-1)*fieldSize.width+x-1];
}

-(int) fightBackgroundIdAtX:(int)x Y:(int)y
{
    // Deprecated
	/*
	for (FDRect *rect in [backgroundDic allValues]) {
		if ([rect isIn:CGPointMake(x, y)]) {
			return [[backgroundDic :rect] intValue];
		}
	}
	 */
	return 1;	// Default value set the 1
	
}

-(void) dealloc {
    
    [blockList release];
    
    [groundPathMapForFly release];
    [groundPathMapForGround release];
    [groundScopeMapForFly release];
    [groundScopeMapForGround release];
    [groundScopeMapForKnight release];
    
    [super dealloc];
    
}

@end
