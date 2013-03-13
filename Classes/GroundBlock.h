//
//  GroundBlock.h
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"

typedef enum GroundBlockType {
	
	GroundBlockTypeGround = 0,
	GroundBlockTypeChasm = 1,
	GroundBlockTypeMarsh = 3,
	GroundBlockTypeGap = 4,
	GroundBlockTypeBlackForest = 5,
	GroundBlockTypeForest = 6
} GroundBlockType;

// DEPRECATED: This shoud be not used, use ScopeBlockType/PathBlockType instead
typedef enum GroundBlockAccessType {

	GroundBlockAccessTypeCanWalk = 0,
	GroundBlockAccessTypeCanFly = 1,
	GroundBlockAccessTypeNone = 2

} GroundBlockAccessType;

@interface GroundBlock : NSObject {

	int defencePoint;	// AP
	int attackPoint;	// DP
	
	// DEPRECATED
	GroundBlockAccessType accessType;		// 1:plain	2:blocked	3:can fly
	
	GroundBlockType blockType;
}

+(id) blockWithType:(GroundBlockType) blockType;

// +(id) blockWithId:(int)i;	// 1: Plain  2: Forest 3: Chasm 4: Gap

// DEPRECATED
-(GroundBlockAccessType) getAccessType;

-(GroupdBlockType) getBlockType;

-(int) attackPoint;
-(int) defencePoint;

@end
