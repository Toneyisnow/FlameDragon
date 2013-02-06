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
#import "EventChapter4.h"
#import "EventChapter5.h"
#import "EventChapter6.h"
#import "EventChapter7.h"
#import "EventChapter8.h"
#import "EventChapter9.h"
#import "EventChapter10.h"
#import "EventChapter11.h"
#import "EventChapter12.h"
#import "EventChapter13.h"
#import "EventChapter14.h"
#import "EventChapter15.h"
#import "EventChapter16.h"
#import "EventChapter17.h"
#import "EventChapter18.h"
#import "EventChapter19.h"
#import "EventChapter20.h"
#import "EventChapter99.h"

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
		case 4:
			loader = [[EventChapter4 alloc] init];
			break;
		case 5:
			loader = [[EventChapter5 alloc] init];
			break;
		case 6:
			loader = [[EventChapter6 alloc] init];
			break;
		case 7:
			loader = [[EventChapter7 alloc] init];
			break;
		case 8:
			loader = [[EventChapter8 alloc] init];
			break;
		case 9:
			loader = [[EventChapter9 alloc] init];
			break;
		case 10:
			loader = [[EventChapter10 alloc] init];
			break;
		case 11:
			loader = [[EventChapter11 alloc] init];
			break;		
		case 12:
			loader = [[EventChapter12 alloc] init];
			break;		
		case 13:
			loader = [[EventChapter13 alloc] init];
			break;		
		case 14:
			loader = [[EventChapter14 alloc] init];
			break;		
		case 15:
			loader = [[EventChapter15 alloc] init];
			break;		
		case 16:
			loader = [[EventChapter16 alloc] init];
			break;		
		case 17:
			loader = [[EventChapter17 alloc] init];
			break;		
		case 18:
			loader = [[EventChapter18 alloc] init];
			break;		
		case 19:
			loader = [[EventChapter19 alloc] init];
			break;		
		case 20:
			loader = [[EventChapter20 alloc] init];
			break;		
		case 99:
			loader = [[EventChapter99 alloc] init];
			break;
		default:
			break;
	}
	
	return [loader autorelease];
}

@end
