//
//  GameStartInfo.m
//  FlameDragon
//
//  Created by sui toney on 12-3-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "GameStartInfo.h"


@implementation GameStartInfo

@synthesize chapterId;

-(id) initWithChapter:(int)l
{
	self = [super init];
	
	chapterId = l;
	
	return self;
}

-(void) encodeWithCoder:(NSCoder *)coder {

	// Should be implemented by sub class
}

-(id) initWithCoder:(NSCoder *)coder {
	
	// Should be implemented by sub class
	return nil;
}


@end
