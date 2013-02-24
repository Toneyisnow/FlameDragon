//
//  FDImage.m
//  FlameDragon
//
//  Created by sui toney on 11-11-5.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDImage.h"


@implementation FDImage

-(id) initFromFile:(NSString *)fileName
{
	self = [super init];
	
	texture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:fileName]];
	
	return self;
}

-(id) initWithTexture:(CCTexture2D *) tex
{
    self = [super init];
	
	texture = [tex retain];
	
	return self;
}

-(CCTexture2D *) texture
{
	return texture;
}

-(void) dealloc
{
	[texture release];
	
	[super dealloc];
}

@end
