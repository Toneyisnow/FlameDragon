//
//  FDSetImageFrameDefinition.h
//  FlameDragon
//
//  Created by sui toney on 11-11-5.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDFrameDefinition.h"
#import "FDImage.h"

@interface FDSetImageFrameDefinition : FDFrameDefinition {

	NSString *imageFileName;
	// FDImage *image;
}

// -(id) initWithImage:(FDImage *)img Time:(int)t;
-(id) initFromFile:(NSString *)fileName Time:(int)t;



@end
