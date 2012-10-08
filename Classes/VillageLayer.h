//
//  VillageLayer.h
//  FlameDragon
//
//  Created by sui toney on 12-4-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ChapterRecord.h"
#import "FDAnimation.h"
#import "FDSprite.h"
#import "ConfirmMessage.h"
#import "FDLayer.h"
#import "SecretSequenceDefinition.h"
#import "VillageLabel.h"

@interface VillageLayer : FDLayer {

	ChapterRecord *chapterRecord;
	
	FDAnimation *cursorAnimation;
	FDSprite *cursor;
	
	FDSprite *secretIndicator;
	
	int currentPosition;	// 0:Amor 1:Item 2:Church 3:Bar 4:Exit
	
	ConfirmMessage *confirmExit;
	
	int secretIndex;
	SecretSequenceDefinition *secretSequence;

	VillageLabel *villageLabel;
}

@property (retain) ChapterRecord *chapterRecord;

-(void) loadWithRecord:(ChapterRecord *) record;

-(void) takeTick;

-(int) getVillageImageId;

-(BOOL) clickedOnButton:(CGPoint)buttonLoc At:(CGPoint)clickedLoc;
-(BOOL) clickedInArea:(CGRect)rect At:(CGPoint)clickedLoc;

-(void) clickEnter;
-(void) clickLeft;
-(void) clickRight;

-(void) enterShop;
-(void) promptExit;
-(void) doExit:(NSNumber *)result;

-(void) setPosition:(int)pos;

@end
