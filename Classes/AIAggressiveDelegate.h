//
//  AIAggressiveDelegate.h
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "AIDelegate.h"
#import "FDCreature.h"
#import "DistanceResolver.h"

@interface AIAggressiveDelegate : AIDelegate {

	DistanceResolver *disResolver;
}

-(CGPoint) generatePos;

-(FDCreature *) findTarget;
-(BOOL) foundInArray:(NSMutableArray *)scopeArray Pos:(CGPoint)targetpos;

-(void) initDistanceResolver;


@end
