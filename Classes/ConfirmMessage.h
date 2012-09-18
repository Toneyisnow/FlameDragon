//
//  ConfirmMessage.h
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDSprite.h"
#import "IMessage.h"

typedef enum ConfirmMessageType
{
	ConfirmMessageType_EndTurn = 1,
	ConfirmMessageType_OpenBox = 2,
	ConfirmMessageType_OpenHiddenBox = 3,
	ConfirmMessageType_LoadGame = 4,
	ConfirmMessageType_SaveGame = 5,
	ConfirmMessageType_QuitGame = 6,
	ConfirmMessageType_ItemFull = 7,
	ConfirmMessageType_LeaveVillage = 8
	
	
} ConfirmMessageType;

typedef enum ConfirmMessageResult
{
	ConfirmMessageResult_Yes = 1,
	ConfirmMessageResult_No = 2,
	ConfirmMessageResult_Cancel = 3
	
} ConfirmMessageResult;


@interface ConfirmMessage : IMessage {

	int creatureAniDefId;
	ConfirmMessageType messageType;
	ConfirmMessageResult result;

	FDSprite *dato;

}

-(id) initWithType:(int)type CreatureAniDefId:(int)defId;

-(BOOL) hasClickedOnYes:(CGPoint)location;
-(BOOL) hasClickedOnNo:(CGPoint)location;

-(CGPoint) buttonYesLocation;
-(CGPoint) buttonNoLocation;

-(void) setSelected:(ConfirmMessageResult)result;
-(ConfirmMessageResult) currentSelected;




@end
