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
	[self addInt:[creature hit] Dimen:3 Pos:CGPointMake(25, 14)];
	[self addInt:[creature ev] Dimen:3 Pos:CGPointMake(25, 2)];
	
	[self addInt:creature.data.level Dimen:2 Pos:CGPointMake(65, 50)];
	[self addInt:creature.data.ex Dimen:2 Pos:CGPointMake(65, 38)];
	[self addInt:creature.data.mv Dimen:2 Pos:CGPointMake(65, 26)];
	
	[self addInt:[creature ap] Dimen:3 Pos:CGPointMake(65, 14)];
	[self addInt:[creature dp] Dimen:3 Pos:CGPointMake(65, 2)];
	
	
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
}

-(void) addString:(NSString *)str Pos:(CGPoint) pos
{
	FDSprite *sprite = [[FDSprite alloc] initWithString:str Size:16];
	[sprite setAnchorPoint:CGPointMake(0, 0)];
	[sprite setLocation:pos];
	[baseSprite addSprite:sprite zOrder:1];	
}

-(void) addInt:(int)value Dimen:(int)dimen Pos:(CGPoint) pos
{
	NSString *template = (dimen == 2) ? @"%02d" : @"%03d";
	
	FDSprite *sprite = [[FDSprite alloc] initWithString:[NSString stringWithFormat:template, value] Size:9];
	[sprite setAnchorPoint:CGPointMake(0, 0)];
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
