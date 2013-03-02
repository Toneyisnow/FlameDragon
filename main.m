//
//  main.m
//  FlameDragon
//
//  Created by sui toney on 11-11-1.
//  Copyright ms 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    @try {
        NSAutoreleasePool *pool = [NSAutoreleasePool new];
        int retVal = UIApplicationMain(argc, argv, nil, @"FlameDragonAppDelegate");
        [pool release];
        return retVal;
     }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
    }
    @finally {
        
    }
	
}
