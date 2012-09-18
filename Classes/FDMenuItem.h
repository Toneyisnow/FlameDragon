//
//  FDMenuItem.h
//  FlameDragon
//
//  Created by sui toney on 11-11-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDBattleObject.h"

@interface FDMenuItem : FDBattleObject {

	int menuItemId;
	BOOL isValid;
	BOOL isSelected;
	
	FDImage *itemImage1;
	FDImage *itemImage2;
	FDImage *itemImage3;
	
	BOOL updated;
}

-(id) initWithId:(int)i;

-(void) setValid:(BOOL)value;
-(BOOL) isValid;

-(void) setSelected:(BOOL)value;
-(BOOL) isSelected;

-(int) getId;


@end
