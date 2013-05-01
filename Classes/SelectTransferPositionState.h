//
//  SelectTransferPositionState.h
//  FlameDragon
//
//  Created by sui toney on 13-5-1.
//
//

#import "DispatcherState.h"
#import "FDFriend.h"

@interface SelectTransferPositionState : DispatcherState {
    
    FDFriend *currentFriend;
    FDCreature *targetCreature;
}

-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien Creature:(FDCreature *)c;

@end
