//
//  AttackInformation.h
//  FlameDragon
//
//  Created by sui toney on 12-10-18.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"


@interface AttackInformation : NSObject {

	int beforeValue;
	int afterValue;
	BOOL isCritical;
}

-(id) initWithBefore:(int)b after:(int)a isCritical:(BOOL)c;

-(int) getBefore;
-(int) getAfter;
-(BOOL) isCritical;

@end
