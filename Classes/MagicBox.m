//
//  MagicBox.m
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "MagicBox.h"
#import "FDSpriteStore.h"
#import "MessageLayer.h"
#import "DataDepot.h"
#import "MagicDefinition.h"
#import "FDWindow.h"
#import "Constants.h"

@implementation MagicBox


@synthesize selectedIndex;

-(id) initWithCreature:(FDCreature *)c Type:(MagicOperatingType)type
{
	self = [super init];
	
	operatingType = type;
	baseSprite = [[[FDSpriteStore instance] sprite:@"ContainerBase.png"] retain];
	creature = [c retain];
	
	datoBar = [[CreatureDato alloc] initWithAniDef:[[c getDefinition] getAnimationId]];
	detailsBar = [[CreatureDetail alloc] initWithCreature:c];
	
	[self initData];
	selectedIndex = -1;
	
	return self;
}

-(void) initData
{
	for (int i = 0; i < [creature.data.magicList count]; i++) {
		
		int magicId = [[creature.data.magicList objectAtIndex:i] intValue];
		CGPoint location = [self getMagicPosition:i];
		//CGPoint location;
		
		MagicDefinition *def = [[DataDepot depot] getMagicDefinition:magicId];
		
		// Name
		FDSprite *nameSprite = [[FDSprite alloc] initWithString:def.name Size:16];	
		[nameSprite setAnchorPoint:CGPointMake(0, 0)];
		[nameSprite setLocation:CGPointMake(location.x, location.y)];
		[baseSprite addSprite:nameSprite zOrder:1];
		[nameSprite release];
		
		// Attribute
		NSString *attri = [NSString stringWithFormat:@"-MP %02d", def.mpCost];
		FDSprite *attSprite = [[FDSprite alloc] initWithString:attri Size:12];	
		[attSprite setAnchorPoint:CGPointMake(0, 0)];
		[attSprite setLocation:CGPointMake(location.x + 50, location.y)];
		[baseSprite addSprite:attSprite zOrder:1];
        [attSprite release];
	}
}

-(void) show:(CCLayer *)l
{
	[super show:l];
	[baseSprite setLocation:[FDWindow showBoxPosition]];
	[baseSprite setScaleX:[Constants battleMapScale] Y:[Constants battleMapScale]];
	
	// Add other Bars
	[datoBar show:l];
	[detailsBar show:l];	
}

-(void) close
{
	[datoBar close];
	[detailsBar close];
	
	[super close];
}

-(void) takeTick:(int)synchronizedTick
{
	
	[datoBar takeTick:synchronizedTick];
	[detailsBar takeTick:synchronizedTick];
}
-(void) clickedOn:(CGPoint)location
{
	if (location.y > [FDWindow winSize].height / 2) {
		
		// Cancel
		returnValue = [NSNumber numberWithInt:-1];
		[self close];
		
		return;
	}
	
	CGPoint innerLoc = [self getInnerLocation:location];
	
	int selected = -1;
	for (int i = 0; i < [creature.data.magicList count]; i++) {
		
		CGPoint itemLoc = [self getMagicPosition:i];
		if (itemLoc.x < innerLoc.x && itemLoc.y < innerLoc.y
			&& innerLoc.x < itemLoc.x + 100 && innerLoc.y < itemLoc.y + 22) {
			selected = i;
			NSLog(@"Clicked on magic %d", i);
			break;
		}
	}
	
	if (selected >= 0) {
		[self selectItem:selected];
	}
}

// Check whether this item can be selected according to current type
-(void) selectItem:(int)selected
{
	if (selected == selectedIndex) {
		returnValue = [NSNumber numberWithInt:selected];
		[self close];
	}
	else {
		selectedIndex = selected;
		
		// show indicator
		[self showIndicator:selected];
	}
}

-(void) showIndicator:(int)selected
{
	if (indicator == nil) {
		indicator = [[[FDSpriteStore instance] sprite:@"ItemIndicator.png"] retain];
		[baseSprite addSprite:indicator zOrder:1];
	}
	[indicator setAnchorPoint:CGPointMake(0, 0)];
	[indicator setOpacity:50];
	[indicator setScaleX:0.6 Y:1.0];
	
	[indicator setLocation:[self getMagicPosition:selected]];
}

-(CGPoint) getMagicPosition:(int)i
{
	int posX = 100*(i / 4) + 10;
	int posY = 73 - 22 * (i % 4);
	
	return CGPointMake(posX, posY);
}

-(void) dealloc
{
	[datoBar release];
	[detailsBar release];
	[creature release];
    
	[super dealloc];
}

@end
