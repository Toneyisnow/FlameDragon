//
//  FDWindow.h
//  FlameDragon
//
//  Created by sui toney on 11-12-21.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"


@interface FDWindow : NSObject {

}

+(CGSize) winSize;

+(CGPoint) screenCenter;
+(CGPoint) downCenter;
+(CGPoint) downLeft;
+(CGPoint) downRight;
+(CGPoint) upCenter;

+(CGPoint) showBoxPosition;
+(CGPoint) showBoxDatoPosition;
+(CGPoint) showBoxDetailPosition;

+(CGPoint) titleButtonStart;
+(CGPoint) titleButtonLoad;
+(CGPoint) titleButtonContinue;

+(CGPoint) villageLocation:(int)position villageImageId:(int)villageImageId;
+(CGPoint) villageLeftButton;
+(CGPoint) villageRightButton;
+(CGPoint) secretIndicatorPosition:(int)villageImageId;


+(CGPoint) showShoppingDialogPosition;
+(CGPoint) chapterRecordShowLocation:(int)recordIndex;
+(CGPoint) shoppingMessageLocation;
+(CGPoint) shoppingMessageLocation2;
+(CGPoint) villageLabelLocation;

+(CGRect) leftWindow;
+(CGRect) rightWindow;

+(CGPoint) moneyBarLocation;

@end
