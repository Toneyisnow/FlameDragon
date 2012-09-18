//
//  FDFileStream.h
//  FlameDragon
//
//  Created by sui toney on 11-11-12.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDRange.h"

@interface FDFileStream : NSObject {

	NSAutoreleasePool * pool;
	//NSString *fileContent;
	
	NSString *fileName;
	FILE *stream;

}

-(id) initWithDataFile:(NSString *)dataFileName;
-(id) initWithDataFile:(NSString *)dataFileName Ext:(NSString *)ext;

-(id) initWithFileName:(NSString *)fileName;

-(void) open;
-(void) close;

-(int) readInt;
-(FDRange *) readRange;
-(NSString *) readString;


@end
