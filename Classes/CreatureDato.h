//
//  CreatureDato.h
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "IBar.h"

@interface CreatureDato : IBar {

	int animationDefId;
	
}

-(id) initWithAniDef:(int)aniDefId;


@end
