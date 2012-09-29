//
//  VillageLayer.m
//  FlameDragon
//
//  Created by sui toney on 12-4-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "VillageLayer.h"
#import "FDSpriteStore.h"
#import "Constants.h"
#import "FDWindow.h"
#import "FDSlideAnimation.h"
#import "ShoppingScene.h"
#import "MainGameScene.h"
#import "BattleRecord.h"

@implementation VillageLayer

@synthesize chapterRecord;

-(id) init
{
	self = [super init];
	
	confirmExit = nil;
	
	return self;
}

// Deprecated Method
-(void) setChapter:(int)chapter
{
	NSString *bgFileName = nil;
	if (chapter <= 10) {
		bgFileName = @"Village-01.png";
	}
	else if (chapter > 10 && chapter <= 20) {
		bgFileName = @"Village-02.png";
	}
	else {
		bgFileName = @"Village-03.png";
	}
	
	FDSprite *bg = [[FDSpriteStore instance] sprite:bgFileName];
	[bg setScaleX:[Constants villageScale] Y:[Constants villageScale]];
	[bg setLocation:[FDWindow screenCenter]];
	
	[self addChild:[bg getSprite]];
}

-(int) getVillageImageId
{
	int chapter = [chapterRecord chapterId];
	return (chapter <= 10) ? 1 : ((chapter <= 20) ? 2 : 3);
}

-(void) loadWithRecord:(ChapterRecord *)record
{
	self.chapterRecord = record;
	
	NSString *bgFileName = [NSString stringWithFormat:@"Village-%02d.png", [self getVillageImageId]];
		
	FDSprite *bg = [[FDSpriteStore instance] sprite:bgFileName];
	[bg setScaleX:[Constants villageScale] Y:[Constants villageScale]];
	[bg setLocation:[FDWindow screenCenter]];
	
	[self addChild:[bg getSprite]];
	
	
	currentPosition = 1;
	cursor = [[FDSpriteStore instance] sprite:@"Icon-001-01.png"];
	AnimationDefinition *animationDef = [AnimationDefinition idleAnimation:1];
	cursorAnimation = [[FDSlideAnimation alloc] initWithDefinition:animationDef Sprite:cursor];
	
	[cursor setScaleX:[Constants villageScale] Y:[Constants villageScale]];
	[cursor setLocation:[FDWindow villageLocation:currentPosition villageImageId:[self getVillageImageId]]];
	[cursor retain];
	[self addChild:[cursor getSprite]];

	villageLabel = [[VillageLabel alloc] init];
	[villageLabel setLocation:[FDWindow villageLabelLocation]];
	[villageLabel setPositionIndex:currentPosition];
	[villageLabel show:self];
	 
	secretIndex = 0;
	secretSequence = [[DataDepot depot] getSecretSequenceDefinition:record.chapterId];
}

-(void) takeTick
{
	if (cursorAnimation != nil) {
		[cursorAnimation takeTick:0];
	}
}

-(void) ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint clickedLoc = [[CCDirector sharedDirector] convertToGL:location];
	
	if (confirmExit != nil) {
		NSLog(@"Clicked with Confirm Message Appeared");
		[confirmExit clickedOn:clickedLoc];
		return;
	}
	
	for (int pos = 0; pos < 6; pos++) {
		if ([self clickedOnButton:[FDWindow villageLocation:pos villageImageId:[self getVillageImageId]] At:clickedLoc])
		{
			if (pos != currentPosition) {
				
				if (pos != 5) {
					[self setPosition:pos];
				}
			} else {
				[self clickEnter];
			}
		}
	}
	
	/*
	if ([self clickedOnButton:[FDWindow villageLocation:currentPosition villageId:[self getVillageId]] At:clickedLoc])
	{
		[self clickEnter];
	}
	else if ([self clickedInArea:[FDWindow leftWindow] At:clickedLoc])
	{
		[self clickLeft];
	}
	else if ([self clickedInArea:[FDWindow rightWindow] At:clickedLoc])
	{
		[self clickRight];
	}
	 */
}

-(BOOL) clickedOnButton:(CGPoint)buttonLoc At:(CGPoint)clickedLoc
{
	return (clickedLoc.x > buttonLoc.x - 40 && clickedLoc.x < buttonLoc.x + 40 && 
			clickedLoc.y > buttonLoc.y - 40 && clickedLoc.y < buttonLoc.y + 40);
}

-(BOOL) clickedInArea:(CGRect)rect At:(CGPoint)clickedLoc
{
	return (clickedLoc.x > rect.origin.x && clickedLoc.x < rect.origin.x + rect.size.width && 
			clickedLoc.y > rect.origin.y && clickedLoc.y < rect.origin.y + rect.size.height);
}

-(void) setPosition:(int)pos
{
	NSLog(@"Set Position : %d", pos);
	
	currentPosition = pos;
	[cursor setLocation:[FDWindow villageLocation:currentPosition villageImageId:[self getVillageImageId]]];	
	[villageLabel setPositionIndex:currentPosition];
	
	
	// For any set position, check the secret index
	if (secretIndex >= [secretSequence totalLength]) {
		secretIndex = 0;
		return;
	}
	
	if (pos == [secretSequence sequenceAtIndex:secretIndex]) {
		secretIndex ++;
	} else {
		secretIndex = 0;
	}
	NSLog(@"Secret Index: %d.", secretIndex);
	
	if (secretIndex >= [secretSequence totalLength]) {
		currentPosition = 5;		
		[cursor setLocation:[FDWindow villageLocation:5 villageImageId:[self getVillageImageId]]];
		[villageLabel setPositionIndex:currentPosition];
	}
}

-(void) clickEnter
{
	NSLog(@"Click Enter");
	secretIndex = 0;
	
	if (currentPosition == 0) {
		[self promptExit];
	} else {
		[self enterShop];
	}
}

-(void) clickLeft
{
	NSLog(@"Click Left");
	
	currentPosition = (currentPosition + 4) % 5;
	[cursor setLocation:[FDWindow villageLocation:currentPosition villageImageId:[self getVillageImageId]]];
}

-(void) clickRight
{
	NSLog(@"Click Right");
	
	currentPosition = (currentPosition + 1) % 5;
	[cursor setLocation:[FDWindow villageLocation:currentPosition villageImageId:[self getVillageImageId]]];
}

-(void) enterShop
{
	Shopping2Type type;
	switch (currentPosition) {
		case 1:
			type = Shopping2Type_Item;
			break;
		case 2:
			type = Shopping2Type_Church;
			break;
		case 3:
			type = Shopping2Type_Bar;
			break;
		case 4:
			type = Shopping2Type_Amor;
			break;
		case 5:
			type = Shopping2Type_Secret;
			break;
		default:
			type = Shopping2Type_Amor;
			break;
	}
	
	ShoppingScene *scene = [ShoppingScene node];
	[scene loadWithRecord:chapterRecord Type:type];	
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
	
	secretIndex = 0;
}

-(void) promptExit
{
	secretIndex = 0;
	
	confirmExit = [[ConfirmMessage alloc] initWithType:ConfirmMessageType_LeaveVillage CreatureAniDefId:0];
	[confirmExit setCallback:self Method:@selector(doExit:)];
	[confirmExit show:self];
}

-(void) doExit:(NSNumber *)result
{
	
	if ([result intValue] != ConfirmMessageResult_Yes) {
		confirmExit = nil;
		return;
	}
	
	NSLog(@"Do Exit");
	
	MainGameScene *mainGame = [MainGameScene node];
	[mainGame loadWithInfo:chapterRecord];
	
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:mainGame]];
	
	//[info release];	
}

-(void) dealloc
{
	[cursor release];
	
	if (confirmExit != nil) {
		[confirmExit release];
		confirmExit = nil;
	}
	
	if (villageLabel != nil) {
		[villageLabel close];
		[villageLabel release];
		villageLabel = nil;
	}
	
	[super dealloc];
}

@end
