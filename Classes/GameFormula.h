//
//  GameFormula.h
//  FlameDragon
//
//  Created by sui toney on 11-12-6.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDCreature.h"
#import "BattleField.h"

@interface GameFormula : NSObject {

}

+(int) getExperienceFromAttack:(FDCreature *)creature Target:(FDCreature *)target Field:(BattleField *)field;
+(int) getExperienceFromMagic:(int)magicId Creature:(FDCreature *)creature Target:(FDCreature *)target Field:(BattleField *)field;
+(int) calculateAttackExp:(FDCreature *)creature Target:(FDCreature *)target;
+(int) recoverHpFromRest:(FDCreature *)creature;

@end
