//
//  AIMagicalDelegate.h
//  FlameDragon
//
//  Created by sui toney on 12-11-8.
//  Copyright 2012 ms. All rights reserved.
//

#import "AIDelegate.h"
#import "MagicDefinition.h"

@interface AIMagicalDelegate : AIDelegate {

	
}

-(NSMutableArray *) getAvailableMagic;
-(void) takeMagicAction;
-(void) takePendAction;
-(void) takeAttackAction;

-(FDCreature *) findAffensiveTarget:(MagicDefinition *)magic;
-(FDCreature *) findDefensiveTarget:(MagicDefinition *)magic;

@end
