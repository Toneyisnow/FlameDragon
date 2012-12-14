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
#import "FightingInformation.h"
#import "MagicalInformation.h"

@interface GameFormula : NSObject {

}

+(FightingInformation *) dealWithAttack:(FDCreature *)subject Target:(FDCreature *)target Field:(BattleField *)field fightBack:(BOOL)fightBack;
+(AttackInformation *) attackFrom:(FDCreature *)creature To:(FDCreature *)target Field:(BattleField *)field;

+(MagicalInformation *) dealWithMagic:(int)magicId From:(FDCreature *)subject Target:(NSArray *)targetList Field:(BattleField *)field;
+(AttackInformation *) magicWithId:(MagicDefinition *)magic From:(FDCreature *)creature To:(FDCreature *)target Field:(BattleField *)field;

+(int) calculateAttackExp:(FDCreature *)creature Target:(FDCreature *)target Info:(AttackInformation *)info;
+(int) calculateMagicExp:(FDCreature *)creature Target:(FDCreature *)target Magic:(MagicDefinition *)magic;


// +(int) getExperienceFromAttack:(FDCreature *)creature Target:(FDCreature *)target Field:(BattleField *)field;
+(int) recoverHpFromRest:(FDCreature *)creature;
+(int) getMoneyNeededForRevive:(CreatureRecord *)creature;

+(int) commonDoubleAttackRate;
+(int) commonCriticalAttackRate;

+(int) getExperienceFromMagic:(int)magicId Creature:(FDCreature *)creature Target:(FDCreature *)target Field:(BattleField *)field;
+(int) calculateAttackExp:(FDCreature *)creature Target:(FDCreature *)target;


+(void) actionedByEnhanceAp:(FDCreature *)creature;
+(void) actionedByEnhanceDp:(FDCreature *)creature;
+(void) actionedByEnhanceDx:(FDCreature *)creature;
+(void) actionedByPoison:(FDCreature *)creature;
+(void) actionedByProhibited:(FDCreature *)creature;
+(void) actionedByFrozen:(FDCreature *)creature;


@end
