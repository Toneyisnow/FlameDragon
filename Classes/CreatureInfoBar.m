//
//  CreatureInfoBar.m
//  FlameDragon
//
//  Created by sui toney on 11-12-2.
//  Copyright 2011 ms. All rights reserved.
//

#import "CreatureInfoBar.h"
#import "FDSpriteStore.h"
#import "MessageLayer.h"

@implementation CreatureInfoBar


-(id) initWithCreature:(FDCreature *)c ClickedOn:(CGPoint)location
{
	self = [super init];
	
	baseSprite = [[FDSpriteStore instance] sprite:@"CreatureInfoBarBase.png"];
	[baseSprite retain];
	
	clickedLocation = location;
	
	creature = c;
	
	//FDSprite *creatureName = [[FDSprite alloc] init];
	//FDSprite *creatureLevel = [[FDSprite alloc] init];
	
	// By default, the HP and MP should be the current value
	hpBar = [[FDSpriteStore instance] sprite:@"CreatureInfoBarHp.png"];
	mpBar = [[FDSpriteStore instance] sprite:@"CreatureInfoBarMp.png"];
	
	[hpBar retain];
	[mpBar retain];
	
	[hpBar setAnchorPoint:CGPointMake(0, 0.5)];
	[mpBar setAnchorPoint:CGPointMake(0, 0.5)];
	
	[hpBar setLocation:CGPointMake(29, 23)];
	[mpBar setLocation:CGPointMake(29, 11)];
	
	hpValue = mpValue = nil;
	
	FDSprite *name = [[FDSprite alloc] initWithString:[creature getName] Size:18];
	[name setLocation:CGPointMake(5, 43)];
	[name setAnchorPoint:CGPointMake(0, 0.5)];
	
	NSLog(@"Level: %d", creature.data.level);
	NSString *levelStr = (creature.data.level < 100) ? [NSString stringWithFormat:@"LV %02d", creature.data.level] : @"LV ??";
	FDSprite *level = [[FDSprite alloc] initWithString:levelStr Size:10];
	[level setLocation:CGPointMake(159, 45)];
	

	//[self addSprite:creatureName zOrder:1];
	//[self addSprite:creatureLevel zOrder:1];
	[baseSprite addSprite:hpBar zOrder:1];
	[baseSprite addSprite:mpBar zOrder:1];
	[baseSprite addSprite:name zOrder:1];
	[baseSprite addSprite:level zOrder:1];
	
	[name release];
	[level release];
	
	[self setHp:creature.data.hpCurrent Mp:creature.data.mpCurrent];
	
	
	return self;
}

-(void) setHp:(int)hp Mp:(int)mp
{
	int hpMax = creature.data.hpMax;
	
	if (hp >= 0) {
		if (hp == 0) {
			[hpBar setOpacity:0];
		}
		else if (hp > 0) {
			[hpBar setOpacity:255];
            
            float scaleX = (float)hp/hpMax;
            if (scaleX < 0.005) {
                scaleX = 0.005;
            }
			[hpBar setScaleX:scaleX Y:1];
		}
		
		if (hpValue != nil) {
			[hpValue removeFromLayer];
			[hpValue release];
			hpValue = nil;
		}
		
		NSString *hpString = (creature.data.hpCurrent < 1000) ? [NSString stringWithFormat:@"%03d", hp] : @"???";
		hpValue = [[FDSprite alloc] initWithString:hpString Size:10];
		[hpValue setLocation:CGPointMake(178, 23)];
		[baseSprite addSprite:hpValue zOrder:1];
	}

	int mpMax = creature.data.mpMax;
	
	if (mp >= 0) {
		if (mp == 0) {
		[mpBar setOpacity:0];
		}
		else if (mp > 0) {
			[mpBar setOpacity:255];
			[mpBar setScaleX:(float)mp/mpMax Y:1];
		}
	
		if (mpValue != nil) {
			[mpValue removeFromLayer];
			[mpValue release];
			mpValue = nil;
		}
	
		// Show the value
		NSString *mpString = (creature.data.hpCurrent < 1000) ? [NSString stringWithFormat:@"%03d", mp] : @"???";
		mpValue = [[FDSprite alloc] initWithString:mpString Size:10];
		[mpValue setLocation:CGPointMake(178, 11)];
		[baseSprite addSprite:mpValue zOrder:1];
	}
	
}

-(void) show:(CCLayer *)l
{
	if ([l isKindOfClass:[MessageLayer class]]) {
		
		MessageLayer *layer = (MessageLayer *)l;
		if(clickedLocation.x > [layer getWinSize].width / 2)
		{
			[baseSprite setLocation:[layer getUpLeftLoc]];
		}
		else
		{
			[baseSprite setLocation:[layer getUpRightLoc]];
		}
	}

	[super show:l];
}

-(void) takeTick:(int)synchronizedTick
{
}

-(void) dealloc
{
    if (hpValue != nil) {
        [hpValue removeFromLayer];
        [hpValue release];
        hpValue = nil;
    }
    
    if (mpValue != nil) {
        [mpValue removeFromLayer];
        [mpValue release];
        mpValue = nil;
    }
	
	[hpBar release];
	[mpBar release];
	[baseSprite release];
	
	[super dealloc];
}

@end
