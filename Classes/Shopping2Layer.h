//
//  Shopping2Layer.h
//  FlameDragon
//
//  Created by sui toney on 12-4-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ChapterRecord.h"
#import "FDAnimation.h"
#import "FDSprite.h"
#import "Shopping2HomeDialog.h"
#import "FDLayer.h"

typedef enum Shopping2Type
{
	Shopping2Type_Exit = 0,
	Shopping2Type_Item = 1,
	Shopping2Type_Church = 2,
	Shopping2Type_Bar = 3,
	Shopping2Type_Amor = 4,
	Shopping2Type_Secret = 5
} Shopping2Type;

@interface Shopping2Layer : FDLayer {
	
	ChapterRecord *chapterRecord;
	
	FDAnimation *cursorAnimation;
	FDSprite *cursor;
	
	Shopping2Type shoppingType;
	
	Shopping2HomeDialog *rootDialog;
	
	//int villagePos;
	
	
	Shopping2Dialog *currentDialog;
	
	IMessage *messageBox;
	
	CGPoint clickStartedLocation;
	
	BOOL scrollEnabled;
	BOOL touchHandled;
	
	int touchCount;
}

@property (retain) ChapterRecord *chapterRecord;
//@property (assign) int villagePos;

-(void) loadWithRecord:(ChapterRecord *) record Type:(Shopping2Type)type;

-(void) takeTick;

-(int) getVillageId;

-(BOOL) clickedOnButton:(CGPoint)buttonLoc At:(CGPoint)clickedLoc;
-(BOOL) clickedInArea:(CGRect)rect At:(CGPoint)clickedLoc;

-(void) handleClick:(CGPoint)location;

-(void) clickEnter;
-(void) clickLeft;
-(void) clickRight;

-(void) setDialog:(Shopping2Dialog *)dia;
-(void) setMessageBox:(IMessage *)msgBox;

-(void) setScrollEnabled:(BOOL)val;

-(void) exitShop;


@end
