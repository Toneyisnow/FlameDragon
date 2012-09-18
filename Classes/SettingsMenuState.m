//
//  SettingsMenuState.m
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "SettingsMenuState.h"


@implementation SettingsMenuState

-(id) initWithLayers:(ActionLayers *)ls Position:(CGPoint)pos
{
	self = [super initWithLayers:ls];
	
	centralPosition = pos;
	
	return self;
}

-(void) clickedOn:(CGPoint)location
{
	CGPoint position = [field convertLocToPos:[field getMapLocationbyScreen:location]];
	FDMenuItem *menuItem = [field getMenuItemByPos:position];
	
	if (menuItem != nil)
	{
		if (![menuItem isSelected])
		{
			if ([menuItem isValid]) {
				[field selectMenuItem:menuItem];
			}
		}
		else
		{
			// Actually do nothing for the settings
		}
	}
	else {
		[field closeMenu];
		shouldDispose = TRUE;
	}
}



@end
