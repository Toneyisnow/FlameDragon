//
//  FDTalkActivity.m
//  FlameDragon
//
//  Created by sui toney on 11-12-4.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDTalkActivity.h"


@implementation FDTalkActivity

-(id) initWithCreature:(FDCreature *)c Message:(NSString *)msg Layer:(MessageLayer *)l
{
	self = [super init];
	
	creature = c;
	message = [msg retain];
	layer = l;
	
	return self;
}

-(void) initialize
{
	talkMessage = [[TalkMessage alloc] initWithCreature:creature Message:message];
	[talkMessage show:layer]; 
}

-(void) mainTick:(int)synchronizeTick
{
	hasFinished = TRUE;
}

-(void) dealloc
{
	[message release];
	[super dealloc];
}

@end
