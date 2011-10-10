//
//  Ball.h
//  AirHockey
//
//  Created by Martin Goffan on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ball : CCLayer<CCTargetedTouchDelegate> {
    cpSpace *space;
    
    CCSprite *ballSprite;
    
    cpVect vec;
}

- (Ball *)initWithPosition:(cpVect)v size:(CGSize)size;

@end
