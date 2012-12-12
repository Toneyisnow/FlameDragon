//
//  FDLocalString.h
//  FlameDragon
//
//  Created by sui toney on 11-12-27.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"


@interface FDLocalString : NSObject {

}

+(NSString *) chapter:(int)charId conversation:(int)converId sequence:(int)sequenceId;
// +(NSString *) chapter:(int)charId conversation:(int)converId sequence:(int)sequenceId choice:(char)choice;
+(NSString *) chapterCreature:(int)charId conversation:(int)converId sequence:(int)sequenceId;

+(NSString *) race:(int)raceId;
+(NSString *) occupation:(int)occupationId;
+(NSString *) creature:(int)creatureDefId;

+(NSString *) item:(int)itemId;
+(NSString *) magic:(int)magicId;

+(NSString *) chapterTitle:(int)charId;
+(NSString *) chapterConditionWin:(int)charId;
+(NSString *) chapterConditionLose:(int)charId;

+(NSString *) villagePositionName:(int)shopIndex;

+(NSString *) confirm:(int)confirmId;
+(NSString *) message:(int)msgId;

+(NSString *) unknown;

@end
