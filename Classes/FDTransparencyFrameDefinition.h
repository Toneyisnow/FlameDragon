//
//  FDTransparencyFrameDefinition.h
//  FlameDragon
//
//  Created by sui toney on 11-11-5.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDFrameDefinition.h"


@interface FDTransparencyFrameDefinition : FDFrameDefinition {

	int opacity;
}

-(id) initWithOpacity:(int)o Time:(int)t;
+(id) frameWithOpaticy:(int)o Time:(int)t;


@end
