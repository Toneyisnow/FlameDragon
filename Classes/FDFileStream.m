//
//  FDFileStream.m
//  FlameDragon
//
//  Created by sui toney on 11-11-12.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDFileStream.h"
#import "Common.h"

@implementation FDFileStream

-(id) initWithDataFile:(NSString *)dataFileName
{
	return [self initWithDataFile:dataFileName Ext:@"dat"];
}

-(id) initWithDataFile:(NSString *)dataFileName Ext:(NSString *)ext
{
	NSString *path = [[NSBundle mainBundle] pathForResource:dataFileName ofType:ext];
	return [self initWithFileName:path];
}

-(id) initWithFileName:(NSString *)fName
{
	self = [super init];
	
	pool = [[NSAutoreleasePool alloc] init];
	fileName = fName;
	
	// fileContent = [NSString stringWithContentsOfFile: fileName];

	return self;
}

-(void) open
{
	const char *cFileName = [fileName cStringUsingEncoding:NSASCIIStringEncoding];
	
	stream = fopen(cFileName, "rt");
	if(stream == nil)
	{
		NSLog(@"Cannot open file %@.", fileName);
	}
	
}

-(void) close
{
	if (stream != nil) {
		fclose(stream);
	}
}

-(int) readInt
{
	if (stream == nil) {
		NSLog(@"Cannot read int from stream. The stream is not opened.");
		return 0;
	}
	
	int result;
	fscanf(stream, "%d", &result);
	return result;
}

-(FDRange *) readRange
{
	int min = [self readInt];
	int max = [self readInt];
	
	return [[[FDRange alloc] initWithMin:min Max:max] autorelease];
}

-(NSString *) readString
{
	if (stream == nil) {
		NSLog(@"Cannot read int from stream. The stream is not opened.");
		return nil;
	}
	
	char str[100];
	fscanf(stream, "%s", str);
	
	return [Common ToString:str];
}

-(void) dealloc
{
	[pool drain];
	[super dealloc];
}


@end
