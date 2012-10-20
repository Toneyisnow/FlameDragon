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
			subject.lastGainedExperience = exp1 + exp2;
		} else {
			subject.lastGainedExperience = exp2;
		}
	} else {
		subject.lastGainedExperience = exp1;
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
				target.lastGainedExperience = backExp1 + backExp2;
			} else {
				target.lastGainedExperience = backExp2;
			}
		} else {
			target.lastGainedExperience = backExp1;
		}
	} else {
		target.lastGainedExperience = 0;
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
	BOOL isHit = [FDRandom hitWithRate:([creature.data hit] - [target.data ev])];
	BOOL isCritical = [FDRandom hitWithRate:[self commonDoubleAttackRate]];
	
	int reduceHp;
	
	if (isHit)
	{
		NSLog(@"GameFormula: isHit");
		
		CGPoint creaturePos = [field getObjectPos:creature];
		GroundBlock *creatureBlock = [[field getGroundField] blockAtX:creaturePos.x Y:creaturePos.y];
		int adjustedAp = [creature.data ap] * (100 + [creatureBlock attackPoint]) / 100;
	
		CGPoint targetPos = [field getObjectPos:target];
		GroundBlock *targetBlock = [[field getGroundField] blockAtX:targetPos.x Y:targetPos.y];
		int adjustedDp = [target.data dp] * (100 + [targetBlock defencePoint]) / 100;
	
		int attackMax = adjustedAp - adjustedDp;
		int attackMin = (adjustedAp - adjustedDp) * 0.9;
		reduceHp = [FDRandom from:attackMin to:attackMax];
		reduceHp = (reduceHp < 0) ? 0 : reduceHp;
		if (isCritical) {
			reduceHp *= 2;
		}
		
		NSLog(@"Reduce HP: (%d - %d) %d", attackMin, attackMax, reduceHp);
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
	
	int totalExp = 0;
	for (FDCreature *target in targetList) {
		AttackInformation *magicInfo = [self magicWithId:magicId From:subject To:target Field:field];
		[result addInformation:magicInfo];
		totalExp += [self calculateAttackExp:subject Target:target Info:magicInfo];
	}
	subject.lastGainedExperience = totalExp;
	
	return [result autorelease];
}	

+(AttackInformation *) magicWithId:(int)magicId From:(FDCreature *)creature To:(FDCreature *)target Field:(BattleField *)field
{
	MagicDefinition *magic = [[DataDepot depot] getMagicDefinition:magicId];
	BOOL isHit = [FDRandom hitWithRate:magic.hittingRate];
	
	int reduceHp;
	
	if (isHit)
	{
		NSLog(@"GameFormula: Magic is Hit");
		
		reduceHp = [FDRandom from:[magic.quantityRange min] to:[magic.quantityRange max]];
		reduceHp = (reduceHp < 0) ? 0 : reduceHp;
		
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
	// Calculate the experience
	int reducedHp = (target.data.hpCurrent > 0) ? [info getBefore] - [info getAfter] : target.data.hpMax;
	int exp = reducedHp * target.data.level * [target getDefinition].data.ex / creature.data.level / target.data.hpMax;
	
	return exp;
}

// DEPRECATED
+(int) getExperienceFromMagic:(int)magicId Creature:(FDCreature *)creature Target:(FDCreature *)target Field:(BattleField *)field
{
	MagicDefinition *magic = [[DataDepot depot] getMagicDefinition:magicId];
	BOOL isHit = [FDRandom hitWithRate:magic.hittingRate];
	
	int reduceHp;
	
	if (isHit)
	{
		NSLog(@"GameFormula: Magic is Hit");
		
		reduceHp = [FDRandom from:[magic.quantityRange min] to:[magic.quantityRange max]];
		reduceHp = (reduceHp < 0) ? 0 : reduceHp;
		
		NSLog(@"Reduce HP: (%d - %d) %d", [magic.quantityRange min], [magic.quantityRange max], reduceHp);
	}
	else
	{
		NSLog(@"GameFormula: not Hit");
		reduceHp = 0;
	}
	
	[target updateHP:-reduceHp];

	creature.lastGainedExperience = [GameFormula calculateAttackExp:creature Target:target];
	return creature.lastGainedExperience;
}

// Deprecated
+(int) calculateAttackExp:(FDCreature *)creature Target:(FDCreature *)target
{
	// Calculate the experience
	int reducedHp = (target.data.hpCurrent > 0) ? target.hpPrevious - target.data.hpCurrent : target.data.hpMax;
	int exp = reducedHp * target.data.level * [target getDefinition].data.ex / creature.data.level / target.data.hpMax;
	
	return exp;
}

+(int) commonDoubleAttackRate
{
	return 80;
}

+(int) commonCriticalAttackRate
{
	return 8;
}

+(int) recoverHpFromRest:(FDCreature *)creature
{
	int recoverHp = [FDRandom from:creature.data.hpMax/15 to:creature.data.hpMax/10];
	return recoverHp;
}

+(int) getMoneyNeededForRevive:(CreatureRecord *)creature
{
	return 100 * creature.data.level;
}


@end
