//
//  FDTalkActivity.h
//  FlameDragon
//
//  Created by sui toney on 11-12-4.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDActivity.h"
#import "FDCreature.h"
#import "TalkMessage.h"
#import "MessageLayer.h"

@interface FDTalkActivity : FDActivity {

	FDCreature *creature;
	NSString *message;
	MessageLayer *layer;
	
	TalkMessage *talkMessage;
}

-(id) initWithCreature:(FDCreature *)c Message:(NSString *)msg Layer:(MessageLayer *)l;

@end
