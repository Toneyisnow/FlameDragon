//
//  FDDrawable.h
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDObject.h"
#import "FDSprite.h"

@interface FDDrawable : FDObject {

	FDSprite *sprite;

}

-(void) setSprite:(FDSprite *)sp;

-(FDSprite *) getSprite;

@end
