//
//  Common.h
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"


@interface Common : NSObject {

}

+(NSString *) ToString:(char *)ch;

+(NSString *) ToString:(int)val Digit:(int)digit;
+(NSString *) GetDocumentDir;
+(NSString *) fileFullPath:(NSString *)fileName;

+(int) maxBetween:(int)val1 and:(int)val2;
+(int) minBetween:(int)val1 and:(int)val2;

@end
