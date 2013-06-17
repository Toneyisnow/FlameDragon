//
//  ShoppingLayer.m
//  FlameDragon
//
//  Created by sui toney on 12-4-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShoppingLayer.h"
#import "FDSpriteStore.h"
#import "Constants.h"
#import "FDWindow.h"
#import "FDSlideAnimation.h"
#import "VillageScene.h"
#import "ShoppingAmorDialog.h"
#import "ShoppingItemDialog.h"
#import "ShoppingBarDialog.h"
#import "ShoppingChurchDialog.h"
#import "SWScrollView.h"



@implementation ShoppingLayer

@synthesize chapterRecord;

-(id) init
{
	self = [super init];
	currentDialog = nil;
	return self;
}

-(int) getVillageId
{
	int chapter = [chapterRecord chapterId];
	return (chapter <= 10) ? 1 : ((chapter <= 20) ? 2 : 3);
}

-(void) loadWithRecord:(ChapterRecord *)record Type:(ShoppingType)type
{
	self.chapterRecord = record;
	shoppingType = type;
	
	
	NSString *bgFileName = [NSString stringWithFormat:@"VillageShop-%02d-%d.png", [self getVillageId], shoppingType];
		
	FDSprite *bg = [[FDSpriteStore instance] sprite:bgFileName];
	[bg setScaleX:[Constants villageScale] Y:[Constants villageScale]];
	[bg setLocation:[FDWindow screenCenter]];
	
	[self addChild:[bg getSprite]];
	
	ShoppingDialog *dialog = nil;
	switch (shoppingType) {
		case ShoppingType_Amor:
			dialog = [[ShoppingAmorDialog alloc] init];
			break;
		case ShoppingType_Item:
			dialog = [[ShoppingItemDialog alloc] init];
			break;
		case ShoppingType_Bar:
			dialog = [[ShoppingBarDialog alloc] init];
			break;
		case ShoppingType_Church:
			dialog = [[ShoppingChurchDialog alloc] init];
			break;
		default:
			break;
	}
	
	[dialog setCallback:self PushMethod:@selector(pushDialog:) ExitMethod:@selector(popDialog)];
	//[dialog setExitCallback:self Method:@selector(popDialog)];
	//[dialog setPushCallback:self Method:@selector(pushDialog:)];
	
	[self pushDialog:dialog];
	[dialog autorelease];
	
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
	
}

-(void) takeTick
{
	
}

-(void) ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint clickedLoc = [[CCDirector sharedDirector] convertToGL:location];
	
	//[self exitShop];
	if (currentDialog != nil) {
		[[currentDialog currentDialog] clickedOn:clickedLoc];
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
	VillageScene *scene = [VillageScene node];
	[scene loadWithRecord:chapterRecord];	
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
	
	int villagePos;
	switch (shoppingType) {
		case ShoppingType_Item:
			villagePos = 1;
			break;
		case ShoppingType_Church:
			villagePos = 2;
			break;
		case ShoppingType_Bar:
			villagePos = 3;
			break;
		case ShoppingType_Amor:
			villagePos = 4;
			break;
		default:
			villagePos = 1;
			break;
	}
	[(VillageLayer *)scene.mainLayer setPosition:villagePos];
}

-(void) pushDialog:(ShoppingDialog *)dialog
{
	NSLog(@"pushDialog");
	
	// Close current dialog
	if (currentDialog != nil) {
		[[currentDialog currentDialog] close];
	}
	
	LinkedDialog *nowDialog = [[LinkedDialog alloc] initWithDialog:dialog Next:currentDialog];
	currentDialog = nowDialog;
	
	[dialog setRecord:chapterRecord];
	[dialog show:self];
}

-(ShoppingDialog *) popDialog
{
	NSLog(@"popDialog");
	
	// Close current dialog
	[[currentDialog currentDialog] close];
	
	// Show previous dialog
	LinkedDialog *nextDialog = [currentDialog getNext];
	[nextDialog retain];
	
	[currentDialog release];
	currentDialog = nextDialog;
	
	if (currentDialog != nil) {
		
		// Pop up and show the previous dialog
		[[currentDialog currentDialog] show:self];
		return [currentDialog currentDialog];
	} else {
		
		// Exit shop
		[self exitShop];
		return nil;
	}
}

-(void) dealloc
{
	[cursor release];
	
	if (currentDialog != nil) {
		[currentDialog release];
		currentDialog = nil;
	}
	
	[super dealloc];
}

@end
