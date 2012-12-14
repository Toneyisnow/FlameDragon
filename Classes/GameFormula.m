//
//  GameFormula.m
//  FlameDragon
//
//  Created by sui toney on 11-12-6.
//  Copyright 2011 ms. All rights reserved.
//

#import "GameFormula.h"
#import "FDRandom.h"
#import "DataDepot.h"
#import "FightingInformation.h"
#import "MagicalInformation.h"
#import "Common.h"

@implementation GameFormula

+(FightingInformation *) dealWithAttack:(FDCreature *)subject Target:(FDCreature *)target Field:(BattleField *)field fightBack:(BOOL)fightBack
{
	AttackInformation *attack1 = [self attackFrom:subject To:target Field:field];
	AttackInformation *attack2 = nil;
	AttackInformation *back1 = nil;
	AttackInformation *back2 = nil;
	
	[attack1 retain];
	
	int exp1 = [self calculateAttackExp:subject Target:target Info:attack1];
	int exp2 = 0;
	int backExp1 = 0;
	int backExp2 = 0;
	
	if (target.data.hpCurrent > 0) {
		BOOL isDoubleHit = [FDRandom hitWithRate:[self commonDoubleAttackRate]];	// TODO: Hard coded
		
		if (isDoubleHit) {
			attack2 = [self attackFrom:subject To:target Field:field];
			[attack2 retain];
			exp2 = [self calculateAttackExp:subject Target:target Info:attack2];
		}
		
		if (target.data.hpCurrent > 0) {
			[subject setLastGainedExperience:exp1 + exp2];
		} else {
			[subject setLastGainedExperience:exp2];
		}
	} else {
		[subject setLastGainedExperience:exp1];
	}

	// Fight back
	if (fightBack && target.data.hpCurrent > 0) {
		
		back1 = [self attackFrom:target To:subject Field:field];
		[back1 retain];
		backExp1 = [self calculateAttackExp:target Target:subject Info:back1];
		
		BOOL isDoubleHit = [FDRandom hitWithRate:[self commonDoubleAttackRate]];	// TODO: Hard coded
		if (subject.data.hpCurrent > 0 && isDoubleHit) {
			back2 = [self attackFrom:target To:subject Field:field];
			[back2 retain];
			backExp2 = [self calculateAttackExp:target Target:subject Info:back2];
			
			if (subject.data.hpCurrent > 0) {
				[target setLastGainedExperience:backExp1 + backExp2];
			} else {
				[target setLastGainedExperience:backExp2];
			}
		} else {
			[target setLastGainedExperience:backExp1];
		}
	} else {
		[target setLastGainedExperience:0];
	}

	FightingInformation *result = [[FightingInformation alloc] initWithAttackInfo:attack1 attack2Info:attack2 backInfo:back1 back2Info:back2];
	if (attack1 != nil) [attack1 release];
	if (attack2 != nil) [attack2 release];
	if (back1 != nil) [back1 release];
	if (back2 != nil) [back2 release];
	
	return [result autorelease];
}

+(AttackInformation *) attackFrom:(FDCreature *)creature To:(FDCreature *)target Field:(BattleField *)field
{
	BOOL isHit = [FDRandom hitWithRate:([creature.data calculatedHit] - [target.data calculatedEv])];
	BOOL isCritical = [FDRandom hitWithRate:[self commonDoubleAttackRate]];
	
	int reduceHp;
	
	if (isHit)
	{
		NSLog(@"GameFormula: isHit");
		
		CGPoint creaturePos = [field getObjectPos:creature];
		GroundBlock *creatureBlock = [[field getGroundField] blockAtX:creaturePos.x Y:creaturePos.y];
		int adjustedAp = [creature.data calculatedAp] * (100 + [creatureBlock attackPoint]) / 100;
	
		CGPoint targetPos = [field getObjectPos:target];
		GroundBlock *targetBlock = [[field getGroundField] blockAtX:targetPos.x Y:targetPos.y];
		int adjustedDp = [target.data calculatedDp] * (100 + [targetBlock defencePoint]) / 100;
	
		int attackMax = adjustedAp - adjustedDp;
		int attackMin = (adjustedAp - adjustedDp) * 0.9;
		reduceHp = [FDRandom from:attackMin to:attackMax];
		reduceHp = (reduceHp < 0) ? 0 : reduceHp;
		if (isCritical) {
			reduceHp *= 2;
		}
		
		NSLog(@"Reduce HP: (%d - %d) %d", attackMin, attackMax, reduceHp);
		
		// Poisoned
		AttackItemDefinition *weapon = [creature.data getAttackItem];
		if (weapon != nil) {
			BOOL isPoisoned = [FDRandom hitWithRate:[weapon getPoisonRate]];
			
			if (isPoisoned) {
				target.data.statusPoisoned = TRUE;
			}
		}
	}
	else
	{
		NSLog(@"GameFormula: not Hit");
		reduceHp = 0;
	}

	AttackInformation *aInfo = [[AttackInformation alloc] initWithBefore:target.data.hpCurrent after:(target.data.hpCurrent - reduceHp) isCritical:isCritical];
	[target updateHP:-reduceHp];
	
	return [aInfo autorelease];
}

+(MagicalInformation *) dealWithMagic:(int)magicId From:(FDCreature *)subject Target:(NSArray *)targetList Field:(BattleField *)field
{
	MagicalInformation *result = [[MagicalInformation alloc] init];
	MagicDefinition *magic = [[DataDepot depot] getMagicDefinition:magicId];
	
	if (magic == nil) {
		return result;
	}
	int totalExp = 0;
	for (FDCreature *target in targetList) {
		AttackInformation *magicInfo = [self magicWithId:magicId From:subject To:target Field:field];
		[result addInformation:magicInfo];
		
		if (magic.magicType == MagicType_Attack || magic.magicType == MagicType_Recover) {
			totalExp += [self calculateAttackExp:subject Target:target Info:magicInfo];
		} else {
			totalExp += [self calculateMagicExp:subject Target:target Magic:magic];
		}

	}
	
	[subject setLastGainedExperience:totalExp];
	
	return [result autorelease];
}

+(AttackInformation *) magicWithId:(MagicDefinition *)magic From:(FDCreature *)creature To:(FDCreature *)target Field:(BattleField *)field
{
	BOOL isHit = [FDRandom hitWithRate:magic.hittingRate];
	
	int reduceHp = 0;
	
	if (isHit)
	{
		NSLog(@"GameFormula: Magic is Hit");
		
		switch (magic.magicType) {
			case MagicType_Attack:
				reduceHp = [FDRandom from:[magic.quantityRange min] to:[magic.quantityRange max]];
				reduceHp = (reduceHp < 0) ? 0 : reduceHp;
				break;
			case MagicType_Recover:
				reduceHp = -[FDRandom from:[magic.quantityRange min] to:[magic.quantityRange max]];
				reduceHp = (reduceHp > 0) ? 0 : reduceHp;
				break;
			case MagicType_Offensive:
				[magic takeOffensiveEffect:target];
				break;
			case MagicType_Defensive:
				[magic takeDefensiveEffect:target];
				break;
			default:
				break;
		}
		
		NSLog(@"Reduce HP: (%d - %d) %d", [magic.quantityRange min], [magic.quantityRange max], reduceHp);
	}
	else
	{
		NSLog(@"GameFormula: not Hit");
		reduceHp = 0;
	}
	
	
	AttackInformation *aInfo = [[AttackInformation alloc] initWithBefore:target.data.hpCurrent after:(target.data.hpCurrent - reduceHp) isCritical:FALSE];
	[target updateHP:-reduceHp];
	
	return [aInfo autorelease];
}

+(int) calculateAttackExp:(FDCreature *)creature Target:(FDCreature *)target Info:(AttackInformation *)info
{
	if (creature == nil || target == nil || info == nil) {
		NSLog(@"Error in calculateAttackExp: object is nil.");
		return 0;
	}
	
	// Calculate the experience
	double calculatedHp = 0;
	
	NSLog(@"Info: %d, %d", [info getBefore], [info getAfter]);
	if (target.data.hpCurrent <= 0) {
		calculatedHp = target.data.hpMax;
	} else {
	
		int after = [Common minBetween:[info getAfter] and:target.data.hpMax];
		after = [Common maxBetween:after and:0];
		
		calculatedHp = [Common getAbs:(double)([info getBefore] - after)];
	}
	NSLog(@"Calculcated HP: %f", calculatedHp);
	
	double exp = 0;
	if ([target getCreatureType] == CreatureType_Enemy) {
		exp = calculatedHp * target.data.level * [target getDefinition].data.ex / (double)creature.data.level / (double)target.data.hpMax;
	} else {
		exp = calculatedHp * 100 * target.data.level / (double)creature.data.level / (double)target.data.hpMax;
	}

	
	NSLog(@"Experience got %d.", (int)exp);
	return (int)exp;
}

+(int) calculateMagicExp:(FDCreature *)creature Target:(FDCreature *)target Magic:(MagicDefinition *)magic
{
	if (creature == nil || target == nil || magic == nil) {
		NSLog(@"Error in calculateMagicExp: object is nil.");
		return 0;
	}
	
	double exp = [magic baseExperience] * target.data.level / creature.data.level;
	
	NSLog(@"Experience got %d.", (int)exp);
	return (int)exp;
}


+(int) commonDoubleAttackRate
{
	return 5;
}

+(int) commonCriticalAttackRate
{
	return 5;
}

+(int) recoverHpFromRest:(FDCreature *)creature
{
	if (creature == nil) return 0;
	
	int recoverHp = [FDRandom from:creature.data.hpMax/15 to:creature.data.hpMax/10];
	return recoverHp;
}

+(int) getMoneyNeededForRevive:(CreatureRecord *)creature
{
	if (creature == nil) return 0;
	
	return 100 * creature.data.level;
}

+(void) actionedByEnhanceAp:(FDCreature *)creature
{
	if (creature == nil) return;
	
	int roundCount = [FDRandom from:2 to:4];
	creature.data.statusEnhanceAp = roundCount;
}

+(void) actionedByEnhanceDp:(FDCreature *)creature
{
	if (creature == nil) return;
	
	int roundCount = [FDRandom from:2 to:4];
	creature.data.statusEnhanceDp = roundCount;
}

+(void) actionedByEnhanceDx:(FDCreature *)creature
{
	if (creature == nil) return;
	
	int roundCount = [FDRandom from:2 to:4];
	creature.data.statusEnhanceDx = roundCount;
}

+(void) actionedByPoison:(FDCreature *)creature
{
	if (creature == nil) return;
	
	int roundCount = [FDRandom from:2 to:4];
	creature.data.statusPoisoned = roundCount;
}

+(void) actionedByProhibited:(FDCreature *)creature
{
	if (creature == nil) return;
	
	int roundCount = [FDRandom from:2 to:4];
	creature.data.statusProhibited = roundCount;
}

+(void) actionedByFrozen:(FDCreature *)creature
{
	if (creature == nil) return;
	
	int roundCount = [FDRandom from:2 to:4];
	creature.data.statusFrozen = roundCount;
}

@end
