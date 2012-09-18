//
//  CreatureDato.m
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "CreatureDato.h"
#import "FDSpriteStore.h"
#import "FDWindow.h"
#import "Constants.h"

@implementation CreatureDato

-(id) initWithAniDef:(int)aniDefId
{
	self = [super init];
	
	animationDefId = aniDefId;
	
	baseSprite = [[FDSpriteStore instance] sprite:@"CreatureDato.png"];
	[baseSprite retain];
	
	NSString *datoFile = [NSString stringWithFormat:@"Dato-%03d-1.png", animationDefId];
	FDSprite *dato = [[FDSpriteStore instance] sprite:datoFile];
	[dato setAnchorPoint:CGPointMake(0, 0)];
	[dato setLocation:CGPointMake(2, 2)];
	[baseSprite addSprite:dato zOrder:1];
	
	return self;
}


-(void) show:(CCLayer *)layer
{
	
	[baseSprite setScaleX:[Constants battleMapScale] Y:[Constants battleMapScale]];
	[baseSprite setLocation:[FDWindow showBoxDatoPosition]];
	[super show:layer];
}

@end

