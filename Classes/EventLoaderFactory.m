//
//  EventLoaderFactory.m
//  FlameDragon
//
//  Created by sui toney on 12-3-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventLoaderFactory.h"
#import "EventChapter1.h"
#import "EventChapter2.h"
#import "EventChapter3.h"

@implementation EventLoaderFactory

+(EventLoader *) createEventLoader:(int)chapterId
{
	EventLoader *loader = nil;
	switch (chapterId) {
		case 1:
			loader = [[EventChapter1 alloc] init];
			break;
		case 2:
			loader = [[EventChapter2 alloc] init];
			break;
		case 3:
			loader = [[EventChapter3 alloc] init];
			break;
		default:
			break;
	}
	
	return [loader autorelease];
}

@end
