//
//  FDSetImageFrameDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-11-5.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDSetImageFrameDefinition.h"
#import "FDSpriteStore.h"

@implementation FDSetImageFrameDefinition


-(id) initFromFile:(NSString *)fileName Time:(int)t
{
	self = [super initWithTime:t];
	imageFileName = [fileName retain];
	return self;
	
	// return [self initWithImage:[[FDSpriteStore instance] image:fileName] Time:t];
}

-(void) renderFrame:(FDSprite *)sprite
{
	// NSLog(@"imageFileName:%@", imageFileName);
	
	FDImage *image = [[FDSpriteStore instance] image:imageFileName];
	[sprite setImage:image];
}

-(void) dealloc
{
	[imageFileName release];
	[super dealloc];
}

@end
