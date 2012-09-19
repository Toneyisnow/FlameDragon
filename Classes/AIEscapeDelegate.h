//
//  AIEscapeDelegate.h
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "AIDelegate.h"
#import "FDPosition.h"

@interface AIEscapeDelegate : AIDelegate {

	FDPosition *escapePosition;
}

// -(void) setEscapePosition:(FDPosition *)pos;


@property (retain, nonatomic) FDPosition *escapePosition;

@end
