//
//  FDImage.h
//  FlameDragon
//
//  Created by sui toney on 11-11-5.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"


@interface FDImage : NSObject {

	CCTexture2D *texture;
}

-(id) initFromFile:(NSString *)fileName;

-(CCTexture2D *) texture;

@end
