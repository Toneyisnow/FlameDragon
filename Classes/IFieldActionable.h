//
//  IField.h
//  FlameDragon
//
//  Created by sui toney on 11-11-7.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDCreature.h"
#import "FDPath.h"
#import "FDMenuItem.h"
#import "FDTreasure.h"
#import "FDPosition.h"

@protocol IFieldActionable

-(void) prepareToMove:(FDCreature *)creature;



-(void) moveCreature:(FDCreature *)creature To:(CGPoint)pos showMenu:(BOOL)willShowMenu;

-(void) cancelPrepare:(FDCreature *)creature;
-(void) removeAllIndicators;


-(void) showMenu:(int)menuId At:(CGPoint)pos;
-(void) selectMenuItem:(FDMenuItem *)item;
-(void) closeMenu;

/*
-(void) shwoActionMenu:(int)menuId For:(FDCreature *)creature;
-(void) showSystemMenu:(int)menuId At:(CGPoint)centralPos;
*/

-(void) selectAttackTarget:(FDCreature *)creature;

-(void) selectMagicTarget:(FDCreature *)creature MagicIndex:(int)magicIndex;
// -(NSMutableArray *) getMagicTargets:(int)magicId Pos:(CGPoint)position;

-(void) selectItemTarget:(FDCreature *)creature IncludeSelf:(BOOL)includeSelf;


//-(void) selectActionTarget:(int)actionId For:(FDCreature *)creature;

-(void) cancelMove:(FDCreature *)creature;

-(void) moveCursor:(int)direction;	// 0:left 1:up 2:right 3:down

-(void) setCursorTo:(CGPoint)pos;
-(void) setCursorObjTo:(FDPosition *)pos;
-(void) setCursorToObject:(FDBattleObject *)obj;
-(void) setCursorSize:(int)size;

//-(void) moveCursorTo:(CGPoint)pos AndTo:(CGPoint)pos2;

//-(void) attackFrom:(FDCreature *)creature Target:(FDCreature *)target;
//-(void) magicFrom:(FDCreature *)creature Targets:(NSMutableArray *)targets;
//-(void) useItem:(FDCreature *)creature ItemId:(int)itemId Target:(FDCreature *)target;
//-(void) giveItem:(FDCreature *)creature ItemId:(int)itemId Target:(FDCreature *)target;
//-(void) endCurrentTurn;

//-(void) takeAction:(int)actionId For:(FDCreature *)creature Target:(FDCreature *)target;
//-(void) cancelAction:(FDCreature *)creature;

-(CGPoint) getMapLocation;
-(void) setMapLocation:(CGPoint)loc;

-(void) showMenu:(int)menuId At:(CGPoint)pos;
-(void) showConfirmMessage:(FDCreature *)creature MessageId:(int)messageId;

// Helper function
-(bool) isInScope:(CGPoint)pos;

-(CGPoint) convertPosToLoc:(CGPoint)pos;
-(CGPoint) convertLocToPos:(CGPoint)loc;
-(CGPoint) getMapLocationbyScreen:(CGPoint)loc;
-(CGPoint) getScreenLocationbyMap:(CGPoint)loc;
-(CGPoint) getCursorPos;
//-(FDPath *) getPath:(CGPoint)pos;

//-(bool) isInteractiveBusy;
//-(bool) isLocked;

-(FDTreasure *) getTreasureAt:(CGPoint) pos;
-(NSMutableArray *) getCreaturesAt:(CGPoint)position Range:(int)range BadGuys:(BOOL)areGadGuys;

//-(void) pickUpTreasure:(FDCreature *) creature;


@end
