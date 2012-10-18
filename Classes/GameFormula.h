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
#import "CreatureRecord.h"

@interface GameFormula : NSObject {

}

+(FightingInformation *) dealWithAttack:(FDCreature *)subject Target:(FDCreature *)target Field:(BattleField *)field fightBack:(BOOL)fightBack
+(int) calculateAttackExp:(FDCreature *)creature Target:(FDCreature *)target Info:(AttackInformation *)info;

// +(int) getExperienceFromAttack:(FDCreature *)creature Target:(FDCreature *)target Field:(BattleField *)field;
+(int) recoverHpFromRest:(FDCreature *)creature;
+(int) getMoneyNeededForRevive:(CreatureRecord *)creature;



+(int) getExperienceFromMagic:(int)magicId Creature:(FDCreature *)creature Target:(FDCreature *)target Field:(BattleField *)field;
+(int) calculateAttackExp:(FDCreature *)creature Target:(FDCreature *)target;

@end
