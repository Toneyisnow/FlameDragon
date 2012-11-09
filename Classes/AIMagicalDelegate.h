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

-(MagicDefinition *) getAvailableMagic;
-(void) takeMagicAction;
-(void) takePendAction;

-(FDCreature *) findAffensiveTarget:(MagicDefinition *)magic;
-(FDCreature *) findDefensiveTarget:(MagicDefinition *)magic;

@end
