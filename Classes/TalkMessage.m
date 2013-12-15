//
//  TalkMessage.m
//  FlameDragon
//
//  Created by sui toney on 11-12-4.
//  Copyright 2011 ms. All rights reserved.
//

#import "TalkMessage.h"
#import "FDLayer.h"
#import "FDSpriteStore.h"
#import "FDFriend.h"
#import "FDWindow.h"

@implementation TalkMessage

@synthesize messagePos;

-(id) initWithCreature:(FDCreature *)c Message:(NSString *)msg
{
	self = [super init];
	
	creature = [c retain];
	
	MaxLineLength = 13;
	ShownCount = 3;
	
	shownMessage = [[NSMutableArray alloc] init];
	
	if (c == nil || [c isKindOfClass:[FDFriend class]]) {
		messagePos = TalkMessagePos_Down;
	}
	else {
		messagePos = TalkMessagePos_Up;
	}	 
	
	baseSprite = [[[FDSpriteStore instance] sprite:@"MessageBox.png"] retain];
	[self splitMessage:msg];
	
	
	return self;
}

-(void) splitMessage:(NSString *)message
{
	messageList  = [[NSMutableArray alloc] init];
	
	int totalLength = [message length];
	int index = 0;
	
	NSString *m;
	do
	{
		int length = totalLength - index;
		if (index + MaxLineLength < totalLength) {
			m = [message substringWithRange:NSMakeRange(index, MaxLineLength)];
			length = MaxLineLength;
		}
		else {
			m = [message substringWithRange:NSMakeRange(index, length)];
		}

		NSRange start = [m rangeOfString:@"#"];
		if (start.location != NSNotFound) {
			m = [m substringWithRange:NSMakeRange(0, start.location)];
			length = start.location + 1;
		}
		
		[messageList addObject:m];
		index += length;
		
	} while (index < totalLength);

}

-(void) show:(CCLayer *)l
{
	CCLOG(@"Show talk message");
	
	showIndex = 0;
	
	[super show:l];
	layer = (FDLayer *)l;
	
	int aniId = (creature != nil) ? [[creature getDefinition] getAnimationId] : 0;
	NSString *datoFile = [NSString stringWithFormat: @"Dato-%03d-1.png", aniId];
	dato = [[[FDSpriteStore instance] sprite:datoFile] retain];
	[baseSprite addSprite:dato zOrder:1];
	
	if (messagePos == TalkMessagePos_Up) {
		[baseSprite setLocation:[FDWindow upCenter]];
		[dato setLocation:CGPointMake([baseSprite size].width - [dato size].width/2 + 1, [dato size].height/2 + 1)];
	}
	else {
		[baseSprite setLocation:[FDWindow downCenter]];
		[dato setLocation:CGPointMake([dato size].width/2 + 1, [dato size].height/2 + 1)];
	}
	
	[self updateMessage];
    
}

-(void) refreshClose
{
    CCLOG(@"refreshClose triggerred.");
    [self clickedOn:CGPointMake(0,0)];
}

-(void) close
{
    [super close];
    [timer invalidate];
}

-(void) updateMessage
{
	for (int i = 0; i < ShownCount; i++) {
		[self showMessage:showIndex + i];
	}

    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(refreshClose) userInfo:nil repeats:NO];
}

-(void) showMessage:(int)index
{	
	if (index >= ShownCount) {
		if ([shownMessage objectAtIndex:0] !=nil) {
			FDSprite *msg = [shownMessage objectAtIndex:0];
			[msg removeFromLayer];
			[shownMessage removeObjectAtIndex:0];
		}
	}
	
	if (index < [messageList count])
	{
		int posX = (messagePos == TalkMessagePos_Up) ? 10 : 10 + [dato size].width;
		int posY = 65 - 20 * (index % ShownCount);
		NSString *message = [messageList objectAtIndex:index];
		
		FDSprite *msg = [[FDSprite alloc] initWithString:message Size:16];
		[msg setAnchorPoint:CGPointMake(0, 0.5)];
		[msg setLocation:CGPointMake(posX, posY)];
		
		[baseSprite addSprite:msg zOrder:1];
		[shownMessage addObject:msg];
		[msg release];
	}
}

-(void) clickedOn:(CGPoint)location
{
	showIndex += ShownCount;
	
	if (showIndex >= [messageList count]) {
		[self close];
	}
	else {
		[self updateMessage];
	}
}

-(void) dealloc
{
    [timer invalidate];
    [creature release];
     
    [super dealloc];
}

@end
