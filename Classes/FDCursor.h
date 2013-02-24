//
//  FDCursor.h
//  FlameDragon
//
//  Created by sui toney on 11-12-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDBattleObject.h"


@interface FDCursor : FDBattleObject {

    int curSize;
}

// Currently only 1,2,3 are supported
-(void) setSize:(int) size;

@end
