//
//  SinglePlayerScene.h
//  RPS
//
//  Created by Martin Goffan on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScoreBoard.h"
#import "Ball.h"
#import "Puck.h"

@interface SinglePlayerScene : CCScene <CCTargetedTouchDelegate, PuckDelegate> {
    CCLayer *bgLayer;
    CCLayer *gameLayer;
    
    Puck* puck[2];
    Ball* ball;
    
    ScoreBoard* myScoreBoard;
    
    cpSpace *space;
    
    int myScore, iScore;
}
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
@end