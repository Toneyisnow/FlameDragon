//
//  Shopping2Dialog.h
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "IBar.h"
#import "ChapterRecord.h"
#import "ItemDefinition.h"
#import "FDWindow.h"

@interface Shopping2Dialog : IBar {
	
	ChapterRecord *chapterRecord;
	
	
	id selectedCallback;
	SEL selectedMethod;
	
	id parentLayer;
	//id returnedObject;
}


-(void) clickedOn:(CGPoint)location;

-(void) addLabel:(NSString *)str Location:(CGPoint)location;

-(BOOL) isClicked:(CGPoint)loc;

-(void) setRecord:(ChapterRecord *)r;

-(void) setSelectedCallback:(id)obj Method:(SEL)method;

-(void) onClicked:(CGPoint)location;

-(void) onExit:(id)returnedObject;

-(ItemDefinition *) getItemDefinition:(int)shopIndex Type:(int)shopType Index:(int)index;

@end

