//
//  Constants.m
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "Constants.h"


@implementation Constants

+(int) unitSize
{
	return 24;
}

+(int) tickLength
{
	return 30;
}

+(int) FPS
{
	return 60; // It seems i cannot change this value
}

+(float) battleMapScale
{
	return 1.5;
}

+(float) villageScale
{
	return 1.5;
}

+(float) commonScale
{
	return 1.5;
}

+(int) fightAnimationIntervalUnit
{
	return 110;
}

+(int) maxPickedFriendCount:(int)chapterId
{
	if (chapterId <= 26)
	{
		return 16;
	}
	
	return 20;
}

@end
