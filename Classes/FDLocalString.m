//
//  FDLocalString.m
//  FlameDragon
//
//  Created by sui toney on 11-12-27.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDLocalString.h"


@implementation FDLocalString



+(NSString *) chapter:(int)charId conversation:(int)converId sequence:(int)sequenceId
{
	NSString *idStr = [NSString stringWithFormat:@"%02d-%02d-%03d", charId, converId, sequenceId];
	NSString *fileName = [NSString stringWithFormat:@"Chapter-%02d", charId];
	return NSLocalizedStringFromTable(idStr, fileName, @"comment");
}

/*
+(NSString *) chapter:(int)charId conversation:(int)converId sequence:(int)sequenceId choice:(char)choice
{
	NSString *idStr = [NSString stringWithFormat:@"%02d-%02d-%03d-%c", charId, converId, sequenceId, choice];
	NSString *fileName = [NSString stringWithFormat:@"Chapter-%02d", charId];
	return NSLocalizedStringFromTable(idStr, fileName, @"comment");
}
*/

+(NSString *) chapterCreature:(int)charId conversation:(int)converId sequence:(int)sequenceId
{
	NSString *idStr = [NSString stringWithFormat:@"%02d-%02d-%03d-Id", charId, converId, sequenceId];
	NSString *fileName = [NSString stringWithFormat:@"Chapter-%02d", charId];
	return NSLocalizedStringFromTable(idStr, fileName, @"comment");
}

+(NSString *) race:(int)raceId
{
	NSString *idStr = [NSString stringWithFormat:@"%03d", raceId];
	
	return NSLocalizedStringFromTable(idStr, @"Race", @"comment");	
}

+(NSString *) occupation:(int)occupationId
{
	NSString *idStr = [NSString stringWithFormat:@"%03d", occupationId];
	
	return NSLocalizedStringFromTable(idStr, @"Occupation", @"comment");		
}

+(NSString *) creature:(int)creatureDefId
{
	NSString *idStr = [NSString stringWithFormat:@"%03d", creatureDefId];
	return NSLocalizedStringFromTable(idStr, @"Creature", @"comment");
}

+(NSString *) chapterTitle:(int)charId
{
	NSString *idStr = [NSString stringWithFormat:@"Title-%02d", charId];
	NSString *fileName = [NSString stringWithFormat:@"Chapter-%02d", charId];
	return NSLocalizedStringFromTable(idStr, fileName, @"comment");	
}

+(NSString *) chapterConditionWin:(int)charId
{
	NSString *fileName = [NSString stringWithFormat:@"Chapter-%02d", charId];
	return NSLocalizedStringFromTable(@"Condition-Win", fileName, @"comment");
}

+(NSString *) chapterConditionLose:(int)charId
{
	NSString *fileName = [NSString stringWithFormat:@"Chapter-%02d", charId];
	return NSLocalizedStringFromTable(@"Condition-Lose", fileName, @"comment");	
}

+(NSString *) villagePositionName:(int)shopPosIndex
{
	NSString *idStr = [NSString stringWithFormat:@"VillagePosition-%d", shopPosIndex];
	return NSLocalizedStringFromTable(idStr, @"Village", @"comment");
}

+(NSString *) confirm:(int)confirmId
{
	NSString *idStr = [NSString stringWithFormat:@"Confirm-%02d", confirmId];
	
	return NSLocalizedStringFromTable(idStr, @"Message", @"comment");			
}

+(NSString *) message:(int)msgId
{
	NSString *idStr = [NSString stringWithFormat:@"Message-%02d", msgId];
	
	return NSLocalizedStringFromTable(idStr, @"Message", @"comment");			
}


@end
