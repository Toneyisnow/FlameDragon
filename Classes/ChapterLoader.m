//
//  ChapterLoader.m
//  FlameDragon
//
//  Created by sui toney on 11-11-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "ChapterLoader.h"
#import "FDFileStream.h"
#import "Common.h"

@implementation ChapterLoader


-(id) initWithId:(int)num
{
	self = [super init];
	
	chapterNumber = num;
	
	// Load map image
	mapImage = [[FDSprite alloc] initFromFile:[NSString stringWithFormat:@"Chapter-%02d.png", num]];
	
	FDFileStream *fileStream = [[FDFileStream alloc] initWithDataFile:[NSString stringWithFormat:@"Chapter-%02d", num]];
	[fileStream open];
	
	ground = [[GroundField alloc] initWithDefinitionStream:fileStream];
	
	[fileStream close];
	[fileStream release];
	
	return self;
}


-(FDSprite *) getMapImage
{
	return mapImage;
}


-(CGSize) getFieldSize
{
	return [ground fieldSize];
}

-(GroundField *) getGroundField
{
	return ground;
}


-(void) dealloc
{
	[mapImage release];
	[ground release];
	
	[super dealloc];
}

@end
