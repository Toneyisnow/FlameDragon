//
//  Shopping2ConfirmDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ConfirmDialog.h"
#import "FDWindow.h"
#import "FDSpriteStore.h"

@implementation Shopping2ConfirmDialog

-(id) initWithMessage:(NSString *)message
{
	self = [super init];
	
	NSRange start = [message rangeOfString:@"#"];
	if (start.location != NSNotFound) {
		
		NSString *message1 = [message substringWithRange:NSMakeRange(0, start.location)];
		NSString *message2 = [message substringWithRange:NSMakeRange(start.location + 1, [message length] - start.location - 1)];
	
		[self addLabel:message1 Location:[FDWindow shoppingMessageLocation]];
		[self addLabel:message2 Location:[FDWindow shoppingMessageLocation2]];
		
	}
	else {
		[self addLabel:message Location:[FDWindow shoppingMessageLocation]];
	}
	
	// Button
	FDSprite *buttonYes = [[FDSpriteStore instance] sprite:@"ConfirmButtonYes.png"];
	[buttonYes setLocation:[self buttonYesLocation]];
	[baseSprite addSprite:buttonYes zOrder:1];
	
	FDSprite *buttonNo = [[FDSpriteStore instance] sprite:@"ConfirmButtonNo.png"];
	[buttonNo setLocation:[self buttonNoLocation]];
	[baseSprite addSprite:buttonNo zOrder:1];
	
	return self;
}

-(void) onClicked:(CGPoint)location
{
	CGPoint innerLoc = [super getInnerLocation:location];
	
	// Bug: This seems a bug of getInnerLocation, that the scale is not correct, but since the 
	//      Battle scene is already using it, I will temporarily modify the location here.
	CGPoint adjustedInnerLoc = CGPointMake(innerLoc.x * [baseSprite getScale].x, innerLoc.y * [baseSprite getScale].y);
	
	//NSLog(@"Clicked innter location: %f, %f", innerLoc.x, innerLoc.y);
	//NSLog(@"Yes Button location: %f, %f", [self buttonYesLocation].x, [self buttonYesLocation].y);
	
	if ([self hasClickedOnYes:adjustedInnerLoc]) {
		CCLOG(@"clicked Yes.");
		[self onExit:[NSNumber numberWithInt:1]];
	}
	else if ([self hasClickedOnNo:adjustedInnerLoc]) {
		CCLOG(@"clicked No.");
		[self onExit:[NSNumber numberWithInt:0]];
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
	return CGPointMake([baseSprite size].width / 2, 20);
}

-(CGPoint) buttonNoLocation
{
	return CGPointMake([baseSprite size].width * 0.8, 20);
}



@end
