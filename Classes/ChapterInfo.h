//
//  ChapterInfo.h
//  FlameDragon
//
//  Created by sui toney on 11-11-22.
//  Copyright 2011 ms. All rights reserved.
//

#import "IMessage.h"
#import "FDSprite.h"
#import "BattleField.h"

@interface ChapterInfo : IMessage {

	//	FDSprite *baseSprite;
	
}

-(void) setChapterNo:(int)chapterNo TurnNo:(int)turnNo;
-(void) setFriendCount:(int)fCount EnemyCount:(int)eCount NpcCount:(int)nCount;
-(void) setCondition:(int)chapterId;
-(void) setMoney:(int)quantity;
//-(void) show:(CCLayer *)l;

@end
