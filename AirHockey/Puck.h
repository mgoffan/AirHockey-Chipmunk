//
//  Puck.h
//  AirHockey
//
//  Created by Martin Goffan on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PuckDelegate <NSObject>
@required
- (void)puck:(CCLayer *)aPuck receivedTouch:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)puck:(CCLayer *)aPuck touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface Puck : CCLayer <CCTargetedTouchDelegate, CCStandardTouchDelegate> {
    cpSpace *space;
    CCSprite *puckSprite;
    cpVect v;
    CGPoint prevLocation;
    
    id<PuckDelegate> delegate;
}

- (Puck *)initWithPosition:(CGPoint)position size:(CGSize)size;

@end

