//
//  AIDefensiveDelegate.h
//  FlameDragon
//
//  Created by sui toney on 13-8-17.
//
//

#import "AIDelegate.h"
#import "FDCreature.h"

@interface AIDefensiveDelegate : AIDelegate {

    FDCreature *operationTarget;
}

// -(CGPoint) generatePos;

-(BOOL) foundInArray:(NSMutableArray *)scopeArray Pos:(CGPoint)targetpos;

@end