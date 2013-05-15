//
//  AIDelegate.h
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDCreature.h"
#import "ActionLayers.h"
#import "DistanceResolver.h"

@interface AIDelegate : NSObject {

	// DistanceResolver *disResolver;

	FDCreature *creature;
	ActionLayers *layers;
}

-(id) initWithCreature:(FDCreature *)c Layers:(ActionLayers *)layers;
// -(void) initDistanceResolver:(FDCreature *)c;
-(CGPoint) generatePos:(CGPoint)targetPos;
// -(CGPoint) generatePos:(CGPoint)targetPos forAttack:(BOOL)attackOnly;
-(void) setParameter:(id)param;

-(void) takeAction;
-(FDCreature *) findTarget;
-(BOOL) needAndCanRecover;
-(void) selfRecover;

@end
