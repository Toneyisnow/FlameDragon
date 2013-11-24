//
//  ActionLayers.h
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "BattleFieldLayer.h"
#import "MessageLayer.h"
#import "FDActivity.h"
#import "CreatureInfoBar.h"
#import "IListener.h"
#import "SideBar.h"
#import "BattleRecord.h"
#import "ChapterRecord.h"
//#import "EventHandler.h"

typedef enum TurnType
{
	TurnType_Friend,
	TurnType_Enemy,
	TurnType_NPC
} TurnType;


@interface ActionLayers : NSObject {

	int chapterId;
	
	BattleFieldLayer *fieldLayer;
	MessageLayer *messageLayer;
	
	BattleField *field;
	
	NSMutableArray *activityList;
	
	bool isLocked;		// This is different from isInteractiveBusy, Locked means the UI cannot be moved
	
	CreatureInfoBar *creatureInfo;
	SideBar *sideBar;
	
	int synchronizeTick;
	int SYNCHRONIZE_TOTAL_INT;

	int turnNo;
	TurnType turnType;
	
	int money;
    int extraInfo;
    
	IListener *eventListener;
	IListener *enemyAiHandler;
	IListener *npcAiHandler;
	
    NSMutableArray *selectedFriendList;
    
    FDActivity *currentActivity;
    
    BOOL gameTernimated;
    BOOL endOfTurn;
}

@property (retain) FDActivity *currentActivity;

-(id) initWithField:(BattleFieldLayer *)fLayer Message:(MessageLayer *)mLayer;

-(void) takeTick;
-(BattleFieldLayer *) getFieldLayer;
-(MessageLayer *) getMessageLayer;

-(void) prepareToMove:(FDCreature *)creature Location:(CGPoint)location;
-(void) moveCreature:(FDCreature *)creature To:(CGPoint)pos showMenu:(BOOL)willShowMenu;
-(void) moveCreatureId:(int)creatureId To:(CGPoint)pos showMenu:(BOOL)willShowMenu;
-(void) moveCreatureSimple:(FDCreature *)creature To:(CGPoint)pos;
-(void) moveCreatureIdSimple:(int)creatureId To:(CGPoint)pos;
-(void) attackFrom:(FDCreature *)creature Target:(FDCreature *)target;
-(void) magicFrom:(FDCreature *)creature TargetPos:(CGPoint)position Id:(int)magicId;
-(void) useItem:(FDCreature *)creature ItemIndex:(int)itemIndex Target:(FDCreature *)target;
-(void) giveItem:(FDCreature *)creature ItemIndex:(int)itemIndex Target:(FDCreature *)target;
-(void) exchangeItem:(FDCreature *)creature ItemIndex:(int)itemIndex Target:(FDCreature *)target ItemIndex:(int)backItemIndex;
-(void) pickUpTreasure:(FDCreature *) creature;
-(void) exchangeTreasure:(FDCreature *)creature withItem:(int)itemIndex;
-(void) transferBy:(FDCreature *)currentFriend forCreature:(FDCreature *)targetCreature to:(CGPoint)position;

-(void) showItemStatus:(FDCreature *)creature;
-(void) showMagicStatus:(FDCreature *)creature;
-(void) showItemStatusAsync:(FDCreature *)creature;
-(void) showMagicStatusAsync:(FDCreature *)creature;

-(void) creatureActionDone:(FDCreature *)creature;
-(void) creaturePendAction:(FDCreature *)creature;
-(void) creatureEndTurn:(FDCreature *)creature;
-(void) startFriendTurn;
-(void) startEnemyTurn;
-(void) startNpcTurn;
-(void) endFriendTurn;
-(void) endEnemyTurn;
-(void) endNpcTurn;
-(void) checkEndTurn;

-(void) startNewGame:(ChapterRecord *)info;
-(void) startNewGame:(ChapterRecord *)info withSelectedFriends:(NSMutableArray *)list;
-(void) loadGame:(BattleRecord *)info; // withEvents:(BOOL)loadEvents;
-(void) saveGame;
-(void) runGame;

-(void) gameOver;
-(void) gameWin;
-(void) gameQuit;
-(void) gameContinue;
-(void) gameCleared;

-(ChapterRecord *) composeChapterRecord;

-(void) clearCreatureInfo;

-(void) notifyEventListener;

-(int) getTurnNumber;
-(TurnType) getTurnType;
-(void) showTurnInfo;
-(void) showChapterInfo;
-(int) getExtraInfo;
-(void) setExtraInfo:(int)val;

-(void) updateSideBarLocation:(CGPoint)loc;

-(void) postFightAction:(FDCreature *)creature Targets:(NSMutableArray *)targets;

-(void) appendNewActivity:(FDActivity *)activity;
-(void) appendToMainActivity:(FDActivity *)activity;
-(void) appendToMainActivityMethod:(SEL)method Param1:(id)obj1 Param2:(id)obj2;
-(void) appendToMainActivityMethod:(SEL)method Param1:(id)obj1 Param2:(id)obj2 Obj:(id)obj;
-(void) appendToCurrentActivity:(FDActivity *)activity;
-(void) appendToCurrentActivityMethod:(SEL)method Param1:(id)obj1 Param2:(id)obj2;
-(void) appendToCurrentActivityMethod:(SEL)method Param1:(id)obj1 Param2:(id)obj2 Obj:(id)obj;
-(void) clearAllActivity;

-(void) receiveNotificationUpdateSideBar:(NSNotification *)notification;

/*
-(void) appendToLastActivity:(FDActivity *)activity;
-(void) appendToLastActivityMethod:(SEL)method Param1:(id)obj1 Param2:(id)obj2;
-(void) appendToLastActivityMethod:(SEL)method Param1:(id)obj1 Param2:(id)obj2 Obj:(id)obj;
-(void) appendToCurrentLastActivity:(FDActivity *)activity;
*/

-(BOOL) isInteractiveBusy;
-(BOOL) isLocked;

-(void) setEventListener:(IListener *)listener;
-(void) setEnemyAiHandler:(IListener *)listener;
-(void) setNpcAiHandler:(IListener *)listener;

-(void) settleFriend:(int)friendIndex At:(CGPoint)loc;

-(void) showTestData;

-(BOOL) isEndOfTurn;

@end
