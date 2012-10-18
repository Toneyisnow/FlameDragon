//
//  FDFightFrameDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-11-24.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDFightFrameDefinition.h"
#import "FDImage.h"
#import "FDSpriteStore.h"

@implementation FDFightFrameDefinition

-(id) initFromFile:(NSString *)fileName Time:(int)t Sound:(int)s Remote:(BOOL)r Hitting:(double)h
{
	self = [super initFromFile:fileName Time:t];
	
	//location = loc;
	soundId = s;
	isRemote = r;
	hittingRate = h;
	
	return self;

}


-(void) renderFrame:(FDSprite *)sprite
{
	//NSLog(@"Render Fight Frame: file=%@", imageFileName);
	FDImage *image = [[FDSpriteStore instance] image:imageFileName];
	[sprite setImage:image];
	
	// Extra
	//[sprite setLocation:location];
	
	// Play Sound
	
}

-(BOOL) isRemote
{
	return isRemote;
}

-(BOOL) isHitting
{
	return hittingRate > 0;
}

-(double) getHittingRate
{
	return hittingRate;
}

@end
