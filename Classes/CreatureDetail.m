//
//  CreatureDetail.m
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "CreatureDetail.h"
#import "FDSpriteStore.h"
#import	"FDWindow.h"
#import "Constants.h"

@implementation CreatureDetail

-(id) initWithCreature:(FDCreature *)c
{
	self = [super init];
	
	creature = c;
	
	baseSprite = [[FDSpriteStore instance] sprite:@"CreatureDetail.png"];
	[baseSprite retain];
	
	[self initData];
	return self;
}

-(void) initData
{
	[self addInt:creature.data.dx Dimen:3 Pos:CGPointMake(25, 26)];
	[self addInt:[creature.data calculatedHit] Dimen:3 Pos:CGPointMake(25, 14)];
	[self addInt:[creature.data calculatedEv] Dimen:3 Pos:CGPointMake(25, 2)];
	
	if ([creature getCreatureType] == CreatureType_Friend) {
		[self addInt:creature.data.ex Dimen:2 Pos:CGPointMake(65, 38)];
	} else {
		[self addInt:100 Dimen:2 Pos:CGPointMake(65, 38)];
	}
	
	[self addInt:creature.data.level Dimen:2 Pos:CGPointMake(65, 50)];
	[self addInt:creature.data.mv Dimen:2 Pos:CGPointMake(65, 26)];
	
	[self addInt:[creature.data calculatedAp] Dimen:3 Pos:CGPointMake(65, 14)];
	[self addInt:[creature.data calculatedDp] Dimen:3 Pos:CGPointMake(65, 2)];
	
	
	[self addInt:creature.data.hpCurrent Dimen:3 Pos:CGPointMake(175, 40)];
	[self addInt:creature.data.hpMax Dimen:3 Pos:CGPointMake(200, 40)];
	[self addInt:creature.data.mpCurrent Dimen:3 Pos:CGPointMake(175, 20)];
	[self addInt:creature.data.mpMax Dimen:3 Pos:CGPointMake(200, 20)];
	
	[self addString:[creature getDefinition].name Pos:CGPointMake(10, 60)];
	[self addString:[[creature getDefinition] getRaceString] Pos:CGPointMake(110, 60)];
	[self addString:[[creature getDefinition] getOccupationString] Pos:CGPointMake(160, 60)];
	
	
	FDSprite *hpBar = [[FDSpriteStore instance] sprite:@"CreatureDetailBarHp.png"];
	FDSprite *mpBar = [[FDSpriteStore instance] sprite:@"CreatureDetailBarMp.png"];
	
	[hpBar retain];
	[mpBar retain];
	
	[hpBar setAnchorPoint:CGPointMake(0, 0.5)];
	[mpBar setAnchorPoint:CGPointMake(0, 0.5)];
	
	[hpBar setLocation:CGPointMake(105, 56)];
	[mpBar setLocation:CGPointMake(105, 37)];
	
	if (creature.data.hpCurrent > 0) {
		[hpBar setScaleX:(float)creature.data.hpCurrent/creature.data.hpMax Y:1];
		[baseSprite addSprite:hpBar zOrder:1];
	}
	
	if (creature.data.mpCurrent > 0) {
		[mpBar setScaleX:(float)creature.data.mpCurrent/creature.data.mpMax Y:1];
		[baseSprite addSprite:mpBar zOrder:1];
	}
	
    [hpBar release];
    [mpBar release];
    
	int statusX = 105;
	int statusY = 13;
	int statusDeltaX = 20;
	if (creature.data.statusEnhanceAp > 0) {
		[self addStatusIcon:@"Status-EnhancedAp.png" Pos:CGPointMake(statusX, statusY)];
	}
	statusX += statusDeltaX;
	if (creature.data.statusEnhanceDp > 0) {
		[self addStatusIcon:@"Status-EnhancedDp.png" Pos:CGPointMake(statusX, statusY)];
	}
	statusX += statusDeltaX;
	if (creature.data.statusEnhanceDx > 0) {
		[self addStatusIcon:@"Status-EnhancedDx.png" Pos:CGPointMake(statusX, statusY)];
	}
	statusX += statusDeltaX;
	if (creature.data.statusPoisoned > 0) {
		[self addStatusIcon:@"Status-Poisoned.png" Pos:CGPointMake(statusX, statusY)];
	}
	statusX += statusDeltaX;
	if (creature.data.statusProhibited > 0) {
		[self addStatusIcon:@"Status-Prohibited.png" Pos:CGPointMake(statusX, statusY)];
	}
	statusX += statusDeltaX;
	if (creature.data.statusFrozen > 0) {
		[self addStatusIcon:@"Status-Frozen.png" Pos:CGPointMake(statusX, statusY)];
	}
}

-(void) addString:(NSString *)str Pos:(CGPoint) pos
{
	FDSprite *sprite = [[FDSprite alloc] initWithString:str Size:16];
	[sprite setAnchorPoint:CGPointMake(0, 0)];
	[sprite setLocation:pos];
	[baseSprite addSprite:sprite zOrder:1];
    [sprite release];
}

-(void) addInt:(int)value Dimen:(int)dimen Pos:(CGPoint) pos
{
	NSString *template = (dimen == 2) ? @"%02d" : @"%03d";
	
	FDSprite *sprite = nil;
	
	if ((dimen == 2 && value <= 99) || (dimen == 3 && value <= 999)) {
		sprite = [[FDSprite alloc] initWithString:[NSString stringWithFormat:template, value] Size:9];
	} else if (dimen == 2) {
		sprite = [[FDSprite alloc] initWithString:@"??" Size:9];
	} else {
		sprite = [[FDSprite alloc] initWithString:@"???" Size:9];
	}


	[sprite setAnchorPoint:CGPointMake(0, 0)];
	[sprite setLocation:pos];
	[baseSprite addSprite:sprite zOrder:1];
    [sprite release];
}

-(void) addStatusIcon:(NSString *)fileName Pos:(CGPoint) pos
{
	FDSprite *sprite = [[FDSpriteStore instance] sprite:fileName];
	[sprite setScaleX:0.75 Y:0.75];
	[sprite setLocation:pos];
	[baseSprite addSprite:sprite zOrder:1];
}

-(void) show:(CCLayer *)layer
{
	[baseSprite setScaleX:[Constants battleMapScale] Y:[Constants battleMapScale]];
	[baseSprite setLocation:[FDWindow showBoxDetailPosition]];
	[super show:layer];
	
}


@end
