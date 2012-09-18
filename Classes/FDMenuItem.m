//
//  FDMenuItem.m
//  FlameDragon
//
//  Created by sui toney on 11-11-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDMenuItem.h"
#import "FDSpriteStore.h"

@implementation FDMenuItem

-(id) initWithId:(int)i
{
	self = [super init];
	
	menuItemId = i;
	
	itemImage1 = [[[FDSpriteStore instance] image:[NSString stringWithFormat:@"Menu-%03d-1.png", i]] retain];
	itemImage2 = [[[FDSpriteStore instance] image:[NSString stringWithFormat:@"Menu-%03d-2.png", i]] retain];
	itemImage3 = [[[FDSpriteStore instance] image:[NSString stringWithFormat:@"Menu-%03d-3.png", i]] retain];
	
	[self setSprite:[[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Menu-%03d-1.png", i]]];
	
	updated = TRUE;
	zOrder = BattleObjectOrder_Menu;
	
	return self;
}

-(void) setValid:(BOOL)value
{
	isValid = value;
	updated = TRUE;
}

-(BOOL) isValid
{
	return isValid;
}

-(void) setSelected:(BOOL)value
{
	isSelected = value;
	updated = TRUE;
}

-(BOOL) isSelected
{
	return isSelected;
}

-(int) getId
{
	return menuItemId;
}

-(void) takeTick:(int)synchronizedTick
{
	//NSLog(@"Menu item take tick %d", synchronizedTick);
	
	if (updated) {
		
		if (isValid) {
				// Show 
				[sprite setImage:itemImage1];
		}
		else {
			// Invalid
			[sprite setImage:itemImage3];
		}

		updated = FALSE;
	}
	
	if (isSelected) {
		// Show animation when selected
		if ((synchronizedTick / 20) % 2 == 0) {
			//NSLog(@"set image1");
			[sprite setImage:itemImage1];
		}
		else {
			//NSLog(@"set image2");
			[sprite setImage:itemImage2];
		}
		
	}
	
}

-(void) dealloc
{
	[itemImage1 release];
	[itemImage2 release];
	[itemImage3 release];
	
	
	[super dealloc];
}

@end
