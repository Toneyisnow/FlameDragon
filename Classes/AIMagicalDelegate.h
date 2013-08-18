//
//  AIMagicalDelegate.h
//  FlameDragon
//
//  Created by sui toney on 13-8-17.
//
//

#import "AIDelegate.h"
#import "FDCreature.h"
#import "MagicDefinition.h"

@interface AIMagicalDelegate : AIDelegate {
    
}

-(NSMutableArray *) getAvailableMagic;
-(void) takeMagicAction;
-(void) takePendAction;

-(FDCreature *) findAffensiveTarget:(MagicDefinition *)magic;
-(FDCreature *) findDefensiveTarget:(MagicDefinition *)magic;


@end
