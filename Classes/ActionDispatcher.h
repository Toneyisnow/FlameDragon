//
//  ActionDispatcher.h
//  FlameDragon
//
//  Created by sui toney on 11-11-7.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "IField.h"
#import "IFieldActionable.h"
#import "FDCreature.h"
#import "DispatcherState.h"
#import "MessageLayer.h"

typedef enum DispatcherStates
{
	DispatcherState_Idle,
	DispatcherState_Locked,
	DispatcherState_ShowingMoveScope,
	DispatcherState_ShowingMenu1,		// Magic, Attack, Item, End
	DispatcherState_ShowingMenu2,		// Exchange, Use, Equip, Throw
	DispatcherState_ShowingMenu3,		// Match, Record, Setting, End
	DispatcherState_ShowingMenu4,		// Save, Info, Load, Quit
	DispatcherState_ShowingMenu5,		// Sound, Music, Animation, Bar

	DispatcherState_SelectingActionTarget,	
	DispatcherState_SelectingItemTarget
} DispatcherStates;

typedef enum BattleActionType
{
	BattleAction_Attack,
	BattleAction_Magic,
	BattleAction_Heal,
	BattleActionId_Prohib
	
} BattleActionType;

@interface ActionDispatcher : NSObject {

	ActionLayers *layers;
	id<IField, IFieldActionable> field;
	// MessageLayer *messageLayer;
	
	NSMutableArray *stateQueue;
	
	// DispatcherStates dispatcherStates;
	
	FDCreature *currentCreature;
	
	BattleActionType battleActionType;
	
	int battleActionId;	// For the magic, heal, we will use it to indicate the ID
}

// -(id) initWithField:(id<IField,IFieldActionable>) fi Message:(MessageLayer *)mLayer;
-(id) initWithLayers:(ActionLayers *)layers;

-(DispatcherState *) getLastState;
-(void) updateState;

-(void) clickedOn:(CGPoint)location;
-(void) pressLeft;
-(void) pressRight;
-(void) pressUp;
-(void) pressDown;
-(void) pressOk;
-(void) pressCancel;

//-(id<IField, IFieldActionable>) getField;


-(CGPoint) getMapLocation;
-(void) setMapLocation:(CGPoint)loc;


@end
