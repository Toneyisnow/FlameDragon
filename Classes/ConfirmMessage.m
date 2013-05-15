//
//  ConfirmMessage.m
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "ConfirmMessage.h"
#import "FDSpriteStore.h"
#import "MessageLayer.h"
#import "FDLocalString.h"
#import "FDWindow.h"
#import "FDLayer.h"

@implementation ConfirmMessage


-(id) initWithType:(int)type CreatureAniDefId:(int)defId
{
	self = [super init];
	
	creatureAniDefId = defId;
	messageType = type;
	result = ConfirmMessageResult_Yes;
	
	baseSprite = [[[FDSpriteStore instance] sprite:@"MessageBox.png"] retain];
	
	return self;
}

-(void) show:(CCLayer *)l
{
	
	CCLOG(@"Show confirm message");
	
	layer = (FDLayer *)l;
	[super show:layer];
	//messageLayer = (MessageLayer *)l;
	
	[baseSprite setLocation:[FDWindow downCenter]];
	
	NSString *datoFile = [NSString stringWithFormat: @"Dato-%03d-1.png", creatureAniDefId];
	dato = [[[FDSpriteStore instance] sprite:datoFile] retain];
	[dato setLocation:CGPointMake([dato size].width/2 + 1, [dato size].height/2 + 1)];
	[baseSprite addSprite:dato zOrder:1];
	
	NSString *promptString = [FDLocalString confirm:messageType];
	FDSprite *prompt = [[FDSprite alloc] initWithString:promptString Size:16];
	[prompt setAnchorPoint:CGPointMake(0, 0.5)];
	[prompt setLocation:CGPointMake(10 + [dato size].width, 65)];
	[baseSprite addSprite:prompt zOrder:1];
	[prompt release];
    
	// Button
	FDSprite *buttonYes = [[FDSpriteStore instance] sprite:@"ConfirmButtonYes.png"];
	[buttonYes setLocation:[self buttonYesLocation]];
	[baseSprite addSprite:buttonYes zOrder:1];
	
	FDSprite *buttonNo = [[FDSpriteStore instance] sprite:@"ConfirmButtonNo.png"];
	[buttonNo setLocation:[self buttonNoLocation]];
	[baseSprite addSprite:buttonNo zOrder:1];
	
}

-(void) clickedOn:(CGPoint)location
{
	result = ConfirmMessageResult_Cancel;
	
	CGPoint innerLoc = [super getInnerLocation:location];
	if ([self hasClickedOnYes:innerLoc]) {
		result = ConfirmMessageResult_Yes;
	}
	else if ([self hasClickedOnNo:innerLoc]) {
		result = ConfirmMessageResult_No;
	}

	if (result != ConfirmMessageResult_Cancel) {
		returnValue = [NSNumber numberWithInt:result];
		[self close];
	}
}

-(BOOL) hasClickedOnYes:(CGPoint)location
{
	// Hard coded
	CGPoint yesPos = [self buttonYesLocation];
	if ((location.x > yesPos.x - 30 && location.x < yesPos.x + 30)
		&& (location.y > yesPos.y - 20 && location.y < yesPos.y + 20)) {
		return TRUE;
	}
	else {
		return FALSE;
	}
}

-(BOOL) hasClickedOnNo:(CGPoint)location
{
	// Hard coded
	CGPoint noPos = [self buttonNoLocation];
	if (location.x > noPos.x - 30 && location.x < noPos.x + 30
		&& location.y > noPos.y - 20 && location.y < noPos.y + 20) {
		return TRUE;
	}
	return FALSE;
}

-(CGPoint) buttonYesLocation
{
	return CGPointMake([baseSprite size].width/2, 20);
}

-(CGPoint) buttonNoLocation
{
	return CGPointMake([baseSprite size].width * 0.8, 20);
}

-(void) setSelected:(ConfirmMessageResult)val
{
	result = val;
}

-(ConfirmMessageResult) currentSelected
{
	return result;
}

-(void) dealloc
{
	[baseSprite release];
	
	if (object != nil) {
		[object release];
	}
	
	[super dealloc];
}

@end
