//
//  ShoppingLayer.h
//  FlameDragon
//
//  Created by sui toney on 12-4-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ChapterRecord.h"
#import "FDAnimation.h"
#import "FDSprite.h"
#import "LinkedDialog.h"

typedef enum ShoppingType
{
	ShoppingType_Exit = 0,
	ShoppingType_Item = 1,
	ShoppingType_Church = 2,
	ShoppingType_Bar = 3,
	ShoppingType_Amor = 4,
	ShoppingType_Secret = 5
} ShoppingType;

@interface ShoppingLayer : CCLayer {

	ChapterRecord *chapterRecord;
	
	FDAnimation *cursorAnimation;
	FDSprite *cursor;
	
	ShoppingType shoppingType;
	
	//int villagePos;
	
	
	LinkedDialog *currentDialog;
}

@property (retain) ChapterRecord *chapterRecord;
//@property (assign) int villagePos;

-(void) loadWithRecord:(ChapterRecord *) record Type:(ShoppingType)type;

-(void) takeTick;

-(int) getVillageId;

-(BOOL) clickedOnButton:(CGPoint)buttonLoc At:(CGPoint)clickedLoc;
-(BOOL) clickedInArea:(CGRect)rect At:(CGPoint)clickedLoc;

-(void) clickEnter;
-(void) clickLeft;
-(void) clickRight;

-(void) exitShop;

-(void) pushDialog:(ShoppingDialog *)dialog;
-(ShoppingDialog *) popDialog;

@end
