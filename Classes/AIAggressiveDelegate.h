//
//  AIAggressiveDelegate.h
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "AIDelegate.h"
#import "FDCreature.h"

@interface AIAggressiveDelegate : AIDelegate {

	FDCreature *attackTarget;
}

// -(CGPoint) generatePos;

-(BOOL) foundInArray:(NSMutableArray *)scopeArray Pos:(CGPoint)targetpos;


@end
