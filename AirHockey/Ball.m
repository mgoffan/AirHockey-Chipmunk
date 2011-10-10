//
//  Ball.m
//  AirHockey
//
//  Created by Martin Goffan on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"

void updateShape(void* ptr, void* unused){
    cpShape* shape = (cpShape*)ptr;
    CCSprite* sprite = shape->data;
    if(sprite){
        cpBody* body = shape->body;
        [sprite setPosition:cpv(body->p.x, body->p.y)];
    }
}

@implementation Ball

-(void)tick:(ccTime)dt{
    cpSpaceStep(space, 1.0f/60.0f);
    cpSpaceHashEach(space->activeShapes, &updateShape, nil);
}
-(void)setupChipmunk{
    cpInitChipmunk();
    space = cpSpaceNew();
    space->gravity = cpv(0, -100);
    space->elasticIterations = 1;
    [self schedule: @selector(tick:) interval: 1.0f/60.0f];
    cpBody* ballBody = cpBodyNew(200.0, INFINITY);
    ballBody->p = vec;
    cpSpaceAddBody(space, ballBody);
    cpShape* ballShape = cpCircleShapeNew(ballBody, 20.0, cpvzero);
    ballShape->e = 1.0;
    ballShape->u = 10000.0;
    ballShape->data = ballSprite;
    ballShape->collision_type = 1;
    cpSpaceAddShape(space, ballShape);
    cpBody* floorBody = cpBodyNew(INFINITY, INFINITY);
    floorBody->p = cpv(0, 0);
    cpShape* floorShape = cpSegmentShapeNew(floorBody, cpv(0,0), cpv(320,0), 0);
    floorShape->e = 0.5;
    floorShape->u = 0.1;
    floorShape->collision_type = 0;
    cpSpaceAddStaticShape(space, floorShape);
}

//- (void)registerWithTouchDispatcher {
//    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
//}

- (Ball *)initWithPosition:(cpVect)v size:(CGSize)size {
    self = [super init];
    if(nil != self){
        ballSprite = [CCSprite spriteWithFile:@"g.png"];
        [ballSprite setPosition:CGPointMake(v.x, v.y)];
        vec = v;
        [self addChild:ballSprite];
        [self setupChipmunk];
    }
    return self;
}

-(id)init{
    self = [super init];
    if(nil != self){
        ballSprite = [CCSprite spriteWithFile:@"g.png"];
        [ballSprite setPosition:CGPointMake(240, 160)];
        [self addChild:ballSprite];
        [self setupChipmunk];
    }
    return self;
}

@end