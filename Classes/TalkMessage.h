//
//  TalkMessage.h
//  FlameDragon
//
//  Created by sui toney on 11-12-4.
//  Copyright 2011 ms. All rights reserved.
//

#import "IMessage.h"
#import "FDCreature.h"

typedef enum TalkMessagePos
{
	TalkMessagePos_Up,
	TalkMessagePos_Down
	
} TalkMessagePos;

@interface TalkMessage : IMessage {

	FDCreature *creature;
	//NSString *message;
	
	NSMutableArray *messageList;
	
	//int clickCount;
	
	int MaxLineLength;
	int ShownCount;
	
	int showIndex;
	
	FDSprite *dato;
	TalkMessagePos messagePos;
	
	NSMutableArray *shownMessage;	
}

-(id) initWithCreature:(FDCreature *)c Message:(NSString *)msg;

-(void) splitMessage:(NSString *)message;
-(void) updateMessage;
-(void) showMessage:(int)index;

@property (nonatomic) TalkMessagePos messagePos;

@end
