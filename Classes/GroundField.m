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
	
    groundMapForGround = [[FDIntMap alloc] initWidth:fieldSize.width Height:fieldSize.height];
	groundMapForFly = [[FDIntMap alloc] initWidth:fieldSize.width Height:fieldSize.height];
	
	
	for (int j = 1; j <= fieldSize.height; j++) {
		for (int i = 1; i <= fieldSize.width; i++) {
				
			GroundBlockType type = [fileStream readInt];
			GroundBlock *block = [GroundBlock blockWithType: type];
			[blockList addObject:block];
            
            switch ([block getAccessType])
			{
				case GroundBlockTypeGround:
					[groundMapForGround setX:i Y:j Value: PathBlockType_Plain];
					[groundMapForFly setX:i Y:j Value: PathBlockType_Plain];
					break;
				case GroundBlockTypeForest:
					[groundMapForGround setX:i Y:j Value: PathBlockType_Plain];
					[groundMapForFly setX:i Y:j Value: PathBlockType_Plain];
					break;
				case GroundBlockTypeChasm:
					[groundMapForGround setX:i Y:j Value: PathBlockType_Blocked];
					[groundMapForFly setX:i Y:j Value: PathBlockType_Plain];
					break;
				case GroundBlockTypeGap:
					[groundMapForGround setX:i Y:j Value: PathBlockType_Blocked];
					[groundMapForFly setX:i Y:j Value: PathBlockType_Blocked];
					break;
				default:
					[groundMapForGround setX:i Y:j Value: PathBlockType_Plain];
					[groundMapForFly setX:i Y:j Value: PathBlockType_Plain];
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

-(FDIntMap *) getGroundMapForGround {
    return groundMapForGround;
}

-(FDIntMap *) getGroundMapForFly {
    return groundMapForFly;
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
    
    [groundMapForFly release];
    [groundMapForGround release];
    
    [super dealloc];
    
}

@end
