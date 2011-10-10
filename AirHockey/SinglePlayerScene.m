//
//  SinglePlayerScene.m
//  RPS
//
//  Created by Martin Goffan on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SinglePlayerScene.h"

@implementation SinglePlayerScene

+(CCScene *) scene
{
    //    MainMenuScene* f = [self node];
    CCScene *scene = (SinglePlayerScene *)[self node];
	return scene;
}

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    [puck[0] setPosition:location];
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"touch move");
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    
    if (location.x >= 240) location.x = 240;
    
    [puck[0] setPosition:location];
}

BOOL backx = NO;
BOOL backy = NO;

/*

- (void)resetGame {
    CGPoint nextPoint = CGPointMake(240, 160);
    [ball stopActionByTag:10];
    [ball runAction:[CCMoveTo actionWithDuration:2.5 position:nextPoint]];
}

- (void)somebodyWon:(BOOL)aYes {
    CCLabelTTF *label;
    if (aYes) {
        label = [CCLabelTTF labelWithString:@"YOU WON!!!" fontName:@"Marker Felt" fontSize:48.0];
        myScore++;
        [myScoreBoard setUserScore:[NSNumber numberWithInt:myScore]];
    }
    else {
        label = [CCLabelTTF labelWithString:@"YOU LOST!!!" fontName:@"Marker Felt" fontSize:48.0];
        iScore++;
        [myScoreBoard setCOMScore:[NSNumber numberWithInt:iScore]];
    }
    [label setColor:ccc3(0, 0, 0)];
    label.position = ccp(240, 160);
    label.scale = 0.0f;
    
    [label setTag:3];
    [gameLayer addChild:label z:1];
    
    CCAction *myAction = [CCSequence actions:[CCSpawn actions:[CCCallFunc actionWithTarget:self selector:@selector(resetGame)] , [CCFadeIn actionWithDuration:3.0], [CCScaleTo actionWithDuration:1.5 scale:1.0f], nil], [CCCallFunc actionWithTarget:self selector:@selector(removeLabel)], nil];
    [label runAction:myAction];
}

- (void)animateController {
    CGPoint nextPoint = CGPointMake(puck[1].position.x, ball.position.y);
    CCAction *myAction = [CCSequence actions:[CCMoveTo actionWithDuration:0.22 position:nextPoint], [CCCallFunc actionWithTarget:self selector:@selector(animateController)], nil];
    [puck[1] runAction:myAction];
}

- (void)animatePuck {
#ifndef kAccelXAxis
#define kAccelXAxis 4.0
#endif
    
#ifndef kAccelYAxis
#define kAccelYAxis 5.0
#endif
    
    CGPoint nextPoint;
        if (ball.position.x == 480.0) {
            nextPoint.x = ball.position.x - kAccelXAxis;
            backx = YES;
            [self somebodyWon:YES];
        }
        else {
            if (ball.position.x == 0.0) {
                nextPoint.x = ball.position.x + kAccelXAxis;
                backx = NO;
                [self somebodyWon:NO];
            }
            else {
                if (backx) {
                    nextPoint.x = ball.position.x - kAccelXAxis;
                }
                else nextPoint.x = ball.position.x + kAccelXAxis;
            }
        }
        
        if (ball.position.y == 0.0) {
            nextPoint.y = ball.position.y + kAccelYAxis;
           backy = YES;
        }
        else {
            if (ball.position.y == 320.0) {
                nextPoint.y = ball.position.y - kAccelYAxis;
                backy = NO;
            }
            else {
                if (backy) {
                    nextPoint.y = ball.position.y + kAccelYAxis;
                }
                else nextPoint.y = ball.position.y - kAccelYAxis;
            }
        }
    
    CCAction *myAction = [CCSequence actions:[CCMoveTo actionWithDuration:0.01 position:nextPoint], [CCCallFunc actionWithTarget:self selector:@selector(animatePuck)], [CCCallFunc actionWithTarget:self selector:@selector(collisionDetector)],nil];
    [myAction setTag:10];
    [ball runAction:myAction];
}

- (void)removeLabel {
    [gameLayer removeChildByTag:3 cleanup:NO];
    [self animatePuck];
}

- (void)collisionDetector {
    BOOL b0 = CGRectIntersectsRect(puck[1].boundingBox, ball.boundingBox);
    BOOL b1 = CGRectIntersectsRect(puck[0].boundingBox, ball.boundingBox);
    
    if (b0 || b1) {
        NSLog(@"collision");
        
        backy = (puck[0].position.y < ball.position.y) ? YES : NO;
        backx = (b1) ? NO : YES;
    }
}



- (void)setUpGameLayer {
    puck[0] = [CCSprite spriteWithFile:@"puck.png"];
    puck[1] = [CCSprite spriteWithFile:@"puck.png"];
    puck[0].position = ccp(20, 160);
    puck[1].position = ccp(460, 160);
    [puck[0] setTag:0];
    [puck[1] setTag:1];
    gameLayer.isTouchEnabled = YES;
    [gameLayer addChild:puck[0] z:0];
    [gameLayer addChild:puck[1] z:0];
    
    ball = [CCSprite spriteWithFile:@"g.png"];
    [ball setTag:2];
//    [gameLayer addChild:ball z:0];
    ball.position = ccp(240, 160);
}

//-(void)tick:(ccTime)dt{
//    cpSpaceStep(space, 1.0f/60.0f);
//    cpSpaceHashEach(space->activeShapes, &updateShape, nil);
//}

//-(void)setupChipmunk{
//    space = cpSpaceNew();
//    space->gravity = cpv(0, 0);
//    space->elasticIterations = 1;
//    
//    [self schedule: @selector(tick:) interval: 1.0f/60.0f];
//    
//    cpBody* floorBody = cpBodyNew(INFINITY, INFINITY);
//    floorBody->p = cpv(0, 0);
//    
//    cpShape* floorShape = cpSegmentShapeNew(floorBody, cpv(0,0), cpv(320,0), 0);
//    floorShape->e = 2.0;
//    floorShape->u = 0.0;
//    floorShape->collision_type = 0;
//    cpSpaceAddStaticShape(space, floorShape);
//}

//- (void)createPucks {
//    cpBody *pucks[2];
//    
//    pucks[0] = cpBodyNew(60.0, INFINITY);
//    pucks[1] = cpBodyNew(60.0, INFINITY);
//    
//    pucks[0]->p = cpv(20 , 160);
//    pucks[1]->p = cpv(460, 160);
//    cpSpaceAddBody(space, pucks[0]);
//    cpSpaceAddBody(space, pucks[1]);
//    
//    cpShape* puckShape[2];
//    puckShape[0] = cpCircleShapeNew(pucks[0], 27.5, cpvzero);
//    puckShape[1] = cpCircleShapeNew(pucks[1], 27.5, cpvzero);
//    puckShape[0]->e = 1.0;
//    puckShape[0]->e = 1.0;
//    puckShape[1]->u = 0.0;
//    puckShape[1]->u = 0.0;
//    puckShape[0]->data = puck[0];
//    puckShape[0]->data = puck[1];
//    puckShape[1]->collision_type = 1;
//    puckShape[1]->collision_type = 1;
//    cpSpaceAddShape(space, puckShape[0]);
//    cpSpaceAddShape(space, puckShape[1]);
//}

//- (void)createBall {
//    cpBody *ballBody = cpBodyNew(60.0, INFINITY);
//    
//    ballBody->p = cpv(240, 160);
//    cpSpaceAddBody(space, ballBody);
//    
//    cpShape *ballShape = cpCircleShapeNew(ballBody, 20.0, cpvzero);
//    ballShape->e = 1.0;
//    ballShape->u = 1.0;
//    ballShape->data = ball;
//    ballShape->collision_type = 1;
//    cpSpaceAddShape(space, ballShape);
//}

*/
 
- (void)setUpBackground {
    CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
    bg.position = ccp(240, 160);
    bgLayer.isTouchEnabled = NO;
    [bgLayer addChild:bg];
}

- (void)puck:(CCLayer *)aPuck receivedTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"aa");
}

- (void)puck:(CCLayer *)aPuck touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"aa");
}

- (void)setUpGameLayer {
    CGSize imageSize = CGSizeMake([UIImage imageNamed:@"puck.png"].size.width, [UIImage imageNamed:@"puck.png"].size.height);
    puck[0] = [[Puck alloc] initWithPosition:ccp(20, 160) size:imageSize];
    puck[1] = [[Puck alloc] initWithPosition:ccp(460, 160) size:imageSize];
    [puck[0] setTag:0];
    [puck[1] setTag:1];
    
    CGSize ballSize = CGSizeMake([UIImage imageNamed:@"g.png"].size.width, [UIImage imageNamed:@"g.png"].size.height);
    ball = [[Ball alloc] initWithPosition:cpv(240, 160) size:ballSize];
    [ball setTag:2];
    
    myScoreBoard = [[ScoreBoard alloc] init];
    myScoreBoard.position = ccp(240, 305);
    
    
    [gameLayer addChild:puck[0] z:0];
    [gameLayer addChild:puck[1] z:0];
    [gameLayer addChild:ball z:0];
    [gameLayer addChild:myScoreBoard z:99];
    
    gameLayer.isTouchEnabled = YES;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"init");
        
        iScore = 0;
        myScore = 0;
        
//        [self registerWithTouchDispatcher];
        
        bgLayer = [CCLayer node];
        gameLayer = [CCLayer node];
        
        [self setUpBackground];
        
        [self setUpGameLayer];
//        [self setupChipmunk];
//        [self createBall];
//        [self createPucks];
        
//        [self animatePuck];
//        [self animateController];
        
        [self addChild:bgLayer z:0];
        [self addChild:gameLayer z:1];
        
    }
    
    return self;
}

@end
