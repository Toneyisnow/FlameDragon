//
//  BattleField.h
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "GroundField.h"
#import "FDSprite.h"
#import "FDBattleObject.h"
#import "IFieldActionable.h"
#import "IField.h"
#import "FDFriend.h"
#import "FDNpc.h"
#import "FDEnemy.h"
#import "FDCursor.h"
#import "CreatureRecord.h"
#import "TreasureRecord.h"
//#import "FDActivity.h"

@interface BattleField : NSObject<IField, IFieldActionable> {

	//StageLoader *stageLoader;
	FDSprite *groundImage;
	
	GroundField *groundField;
	//GroundBlock[][] groundBlocks;
	
	int fieldChapterId;
	int fieldWidth;
	int fieldHeight;
	
	NSMutableArray *battleObjectList;
	NSMutableArray *friendList;
	NSMutableArray *npcList;
	NSMutableArray *enemyList;
	//NSMutableArray *activityList;
	
	NSMutableArray *deadCreatureList;
	
	NSMutableArray *unsettledCreatureList;
	
	FDCursor *cursor;
	CGPoint cursorPoint;
	
}

-(id) initWithChapter:(int)chapter;
-(void) loadMapData:(int) num;


-(void) addObject:(FDBattleObject *)obj Position:(CGPoint)pos;
-(void) removeObject:(FDBattleObject *)obj;

-(void) addFriend:(FDFriend *)fri Position:(CGPoint)pos;
-(void) addEnemy:(FDEnemy *)cre Position:(CGPoint)pos;
-(void) addEnemy:(FDEnemy *)cre Around:(CGPoint)pos;
-(void) addNpc:(FDNpc *)npc Position:(CGPoint)pos;
-(NSMutableArray *) getFriendList;
-(NSMutableArray *) getEnemyList;
-(NSMutableArray *) getNpcList;
-(NSMutableArray *) getDeadCreatureList;
-(NSMutableArray *) getUnsettledCreatureList;

-(NSMutableArray *) getTreasureList;

-(FDCreature *) getCreatureById:(int)iden;
-(FDCreature *) getDeadCreatureById:(int)iden;
-(FDCreature *) getUnsettledCreatureById:(int)iden;

-(CreatureRecord *) generateCreatureRecord:(FDCreature *)creature;
-(TreasureRecord *) generateTreasureRecord:(FDTreasure *)treasure;

-(BOOL) isNextTo:(FDCreature *)creature1 And:(FDCreature *)creature2;
-(int) getDirectDistance:(FDCreature *)creature1 And:(FDCreature *)creature2;
-(int) getDirectDistancePos:(CGPoint)pos1 And:(CGPoint)pos2;

-(FDCreature *) getCreatureThatCarriesItem:(int)itemId;

-(void) takeTick:(int)synchronizeTick;

-(FDSprite *) getSprite;

-(CGSize) mapSize;

-(GroundField *) getGroundField;

-(int) getBackgroundPicId:(CGPoint)pos;
-(int) getChapterId;

-(NSMutableArray *) searchMoveScope:(FDCreature *)creature;
-(NSMutableArray *) searchActionScope:(CGPoint)pos Range:(FDRange *)range;
-(NSMutableArray *) getEnemyInAttackScope:(FDCreature *)creature;
-(NSMutableArray *) getNearByFriend:(FDCreature *)creature;

-(FDPath *) getMovePath:(FDCreature *)creature To:(CGPoint)pos;

-(void) showMenuO:(NSNumber *)menuId At:(FDPosition *)pos;

-(void) startNewTurn;

@end
