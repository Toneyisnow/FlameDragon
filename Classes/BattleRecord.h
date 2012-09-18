//
//  GameLoadedInfo.h
//  FlameDragon
//
//  Created by sui toney on 12-3-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "GameStartInfo.h"
#import "CreatureRecord.h"
#import "FDFileStream.h"

@interface BattleRecord : GameStartInfo {

	int turnNo;
	int money;
	NSMutableArray *friendRecords;
	NSMutableArray *enemyRecords;
	NSMutableArray *npcRecords;
	NSMutableArray *deadCreatureRecords;
	
	NSMutableArray *treasureRecords;
	NSMutableArray *activeEventIds;
	
	BOOL withAllEvents;
}

-(id) initWithTestData;

// Note: this method is deprecated
-(id) initWithChapterRecord:(GameStartInfo *)info;

-(NSMutableArray *) friendRecords;
-(NSMutableArray *) enemyRecords;
-(NSMutableArray *) npcRecords;
-(NSMutableArray *) deadCreatureRecords;
-(NSMutableArray *) treasureRecords;
-(NSMutableArray *) activeEventIds;

@property (nonatomic, assign) int turnNo, money;
@property (nonatomic, assign) BOOL withAllEvents;

@end
