//
//  AITreasureDelegate.h
//  FlameDragon
//
//  Created by sui toney on 13-6-17.
//
//

#import "AIDelegate.h"
#import "FDPosition.h"

@interface AITreasureDelegate : AIDelegate {
    
	CGPoint escapePosition;
    CGPoint treasurePosition;
}

@property CGPoint escapePosition;


-(void) checkEndTurnCondition;

@end
