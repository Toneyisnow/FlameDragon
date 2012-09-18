//
//  FDNpc.h
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDCreature.h"


@interface FDNpc : FDCreature {

}

-(id) initWithDefinition:(int)identity Id:(int)i;
-(id) initWithDefinition:(int)identity Id:(int)i Data:(CreatureData *)dat;
-(id) initWithSavedState:(int)record;
-(id) initWithCreature:(FDCreature *)creature;


@end
