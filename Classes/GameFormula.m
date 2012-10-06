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

@implementation GameFormula

+(int) getExperienceFromAttack:(FDCreature *)creature Target:(FDCreature *)target Field:(BattleField *)field
{
	BOOL isHit = [FDRandom hitWithRate:([creature.data hit] - [target.data ev])];
	
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
		
		NSLog(@"Reduce HP: (%d - %d) %d", attackMin, attackMax, reduceHp);
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

+(int) calculateAttackExp:(FDCreature *)creature Target:(FDCreature *)target
{
	// Calculate the experience
	int reducedHp = (target.data.hpCurrent > 0) ? target.hpPrevious - target.data.hpCurrent : target.data.hpMax;
	int exp = reducedHp * target.data.level * [target getDefinition].data.ex / creature.data.level / target.data.hpMax;
	
	return exp;
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
