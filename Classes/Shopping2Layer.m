//
//  Shopping2Layer.m
//  FlameDragon
//
//  Created by sui toney on 12-4-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2Layer.h"
#import "FDSpriteStore.h"
#import "Constants.h"
#import "FDWindow.h"
#import "FDSlideAnimation.h"
#import "VillageScene.h"
#import "Shopping2AmorDialog.h"
#import "Shopping2ItemDialog.h"
#import "Shopping2BarDialog.h"
#import "Shopping2ChurchDialog.h"
#import "SWScrollView.h"



@implementation Shopping2Layer

@synthesize chapterRecord;

-(id) init
{
	self = [super init];
	
	currentDialog = nil;
	rootDialog = nil;
	messageBox = nil;
	
	scrollEnabled = FALSE;
	touchHandled = FALSE;
	touchCount = 0;
	
	return self;
}

-(int) getVillageId
{
	int chapter = [chapterRecord chapterId];
	return (chapter <= 10) ? 1 : ((chapter <= 20) ? 2 : 3);
}

-(void) loadWithRecord:(ChapterRecord *)record Type:(Shopping2Type)type
{
	self.chapterRecord = record;
	shoppingType = type;
	
	
	NSString *bgFileName = [NSString stringWithFormat:@"VillageShop-%02d-%d.png", [self getVillageId], shoppingType];
	
	FDSprite *bg = [[FDSpriteStore instance] sprite:bgFileName];
	[bg setScaleX:[Constants villageScale] Y:[Constants villageScale]];
	[bg setLocation:[FDWindow screenCenter]];
	
	[self addChild:[bg getSprite]];
	
	switch (shoppingType) {
		case Shopping2Type_Amor:
			rootDialog = [[Shopping2AmorDialog alloc] init];
			break;
		case Shopping2Type_Item:
			rootDialog = [[Shopping2ItemDialog alloc] init];
			break;
		case Shopping2Type_Bar:
			rootDialog = [[Shopping2BarDialog alloc] init];
			break;
		case Shopping2Type_Church:
			rootDialog = [[Shopping2ChurchDialog alloc] init];
			break;
		default:
			break;
	}
	
	[rootDialog initButtons];
	[rootDialog setRecord:chapterRecord];
	[rootDialog show:self];
	
	
	/*
	SWScrollView *view = [SWScrollView viewWithViewSize: CGSizeMake(300, 100)];
	view.position = ccp(0, 0);
	view.contentOffset = ccp(0, 0);
	view.direction = SWScrollViewDirectionVertical;
	view.clipsToBounds = YES;
	
	
	CCSprite *sprite1 = [CCSprite spriteWithFile:@"Icon-001-01.png"];
	CCSprite *sprite2 = [CCSprite spriteWithFile:@"Icon-002-01.png"];
	CCSprite *sprite3 = [CCSprite spriteWithFile:@"Icon-003-01.png"];
	CCSprite *sprite4 = [CCSprite spriteWithFile:@"Icon-004-01.png"];
	
	view.contentSize = CGSizeMake(300, 350);
	
	sprite1.position = ccp(100, 0);
	sprite1.scaleX = 1.5; sprite1.scaleY = 1.5;
	sprite2.position = ccp(100, 100);
	sprite2.scaleX = 1.5; sprite2.scaleY = 1.5;
	sprite3.position = ccp(100, 200);
	sprite3.scaleX = 1.5; sprite3.scaleY = 1.5;
	sprite4.position = ccp(100, 300);
	sprite4.scaleX = 1.5; sprite4.scaleY = 1.5;
	
	[view addChild:sprite1];
	[view addChild:sprite2];
	[view addChild:sprite3];
	[view addChild:sprite4];
	[self addChild:view];
	*/
}

-(void) takeTick
{
	
}

-(void) ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {

	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint clickedLoc = [[CCDirector sharedDirector] convertToGL:location];

	
	// Resolve the multi touch issue
	touchCount ++;
	NSLog(@"++ touchCount: %d", touchCount);
	if (touchCount > 1) {
		return;
	}
	
	if (scrollEnabled) {
		clickStartedLocation = clickedLoc;
		touchHandled = FALSE;
		return;
	}
	else {
		touchHandled = TRUE;
		[self handleClick:clickedLoc];
	}
}

-(void) ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint clickedLoc = [[CCDirector sharedDirector] convertToGL:location];
	
	// Resolve the multi touch issue
	touchCount --;
	NSLog(@"-- touchCount: %d", touchCount);
	if (touchCount > 0) {
		return;
	}
	if (touchCount < 0) {
		touchCount = 0;
	}
	
	if (touchHandled) {
		return;
	}
	
	NSLog(@"Clicked end;");
	
	touchHandled = FALSE;
	
	if (clickedLoc.x > clickStartedLocation.x + 5 || clickedLoc.x < clickStartedLocation.x - 5
		|| clickedLoc.y > clickStartedLocation.y + 5 || clickedLoc.y < clickStartedLocation.y - 5) {
		// If moved, skip
		return;
	}

	[self handleClick:clickedLoc];
}

-(void) handleClick:(CGPoint)clickedLoc
{
	
	//[self exitShop];
	if (currentDialog != nil) {
		[currentDialog clickedOn:clickedLoc];
	}
	else if (messageBox != nil) {
		[messageBox clickedOn:clickedLoc];
	}
	else if ([rootDialog isClicked:clickedLoc]) {
		[rootDialog clickedOn:clickedLoc];
	}
	else {
		[self exitShop];
	}
	
}

-(BOOL) clickedOnButton:(CGPoint)buttonLoc At:(CGPoint)clickedLoc
{
	return (clickedLoc.x > buttonLoc.x - 20 && clickedLoc.x < buttonLoc.x + 20 && 
			clickedLoc.y > buttonLoc.y - 20 && clickedLoc.y < buttonLoc.y + 20);
}

-(BOOL) clickedInArea:(CGRect)rect At:(CGPoint)clickedLoc
{
	return (clickedLoc.x > rect.origin.x && clickedLoc.x < rect.origin.x + rect.size.width && 
			clickedLoc.y > rect.origin.y && clickedLoc.y < rect.origin.y + rect.size.height);
}

-(void) clickEnter
{
	NSLog(@"Click Enter");
	
}

-(void) clickLeft
{
}

-(void) clickRight
{
}

-(void) exitShop
{
	touchCount = 0;
	touchHandled = FALSE;
	
	VillageScene *scene = [VillageScene node];
	[scene loadWithRecord:chapterRecord];	
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
	
	int villagePos;
	switch (shoppingType) {
		case Shopping2Type_Item:
			villagePos = 1;
			break;
		case Shopping2Type_Church:
			villagePos = 2;
			break;
		case Shopping2Type_Bar:
			villagePos = 3;
			break;
		case Shopping2Type_Amor:
			villagePos = 4;
			break;
		default:
			villagePos = 1;
			break;
	}
	[scene.mainLayer setPosition:villagePos];
}

-(void) setDialog:(Shopping2Dialog *)dia
{
	if (currentDialog != nil) {
		[currentDialog release];
		currentDialog = nil;
	}
	
	if (dia != nil) {
		currentDialog = [dia retain];
	}
}

-(void) setMessageBox:(IMessage *)msgBox
{
	if (messageBox != nil) {
		[messageBox release];
		messageBox = nil;
	}
	
	if (msgBox != nil) {
		messageBox = [msgBox retain];
	}
}

-(void) setScrollEnabled:(BOOL)val
{
	scrollEnabled = val;
}

-(void) dealloc
{
	[cursor release];
	
	if (currentDialog != nil) {
		[currentDialog release];
		currentDialog = nil;
	}
	
	if (rootDialog != nil) {
		[rootDialog release];
		rootDialog = nil;
	}
	
	if (messageBox != nil) {
		[messageBox release];
		messageBox = nil;
	}
	
	[super dealloc];
}

@end
