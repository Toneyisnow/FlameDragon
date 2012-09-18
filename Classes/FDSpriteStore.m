//
//  FDSpriteStore.m
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDSpriteStore.h"

static FDSpriteStore *instance;

@implementation FDSpriteStore

-(id) init
{
	self = [super init];
	
	spriteDictionary = [[NSMutableDictionary alloc] init];
	imageDictionary = [[NSMutableDictionary alloc] init];
	
	return self;
}


+(id) instance
{
	@synchronized(instance)
	{
		if(instance == nil)
		{
			instance = [[self alloc] init];
		}
		return instance;
	}
}

-(FDImage *) image:(NSString *)fileName
{
	if ([imageDictionary objectForKey:fileName] == nil)
	{
		FDImage *image = [[FDImage alloc] initFromFile:fileName];
		[imageDictionary setObject:image forKey:fileName];
		[image release];
	}
	
	return [imageDictionary objectForKey:fileName];	
}


-(FDSprite *) sprite:(NSString *)fileName
{
	FDSprite *sprite = [[FDSprite alloc] initFromFile:fileName];
	
	return [sprite autorelease];
	
	/*
	NSString *identi = [NSString stringWithFormat:@"%@_%d", fileName, i];
	
	if ([spriteDictionary objectForKey:identi] == nil)
	{
		FDSprite *sprite = [[FDSprite alloc] initFromFile:fileName];
		[spriteDictionary setObject:sprite forKey:identi];
		[sprite release];
	}
	
	return [spriteDictionary objectForKey:identi];
	 */
}

-(FDSprite *) emptySprite
{
	return [self sprite: @"Empty.png"];
}

@end
