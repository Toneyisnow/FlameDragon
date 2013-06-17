//
//  VillageNonLayer.h
//  FlameDragon
//
//  Created by sui toney on 13-6-16.
//
//

#import "VillageCommonLayer.h"
#import "ChapterRecord.h"
#import "ConfirmMessage.h"
#import "Shopping2RecordDialog.h"

@interface VillageNonLayer : VillageCommonLayer {
    
    ConfirmMessage *confirmSave;
    
    Shopping2RecordDialog *recordDialog;
	
}

//+(id) scene;

@end
