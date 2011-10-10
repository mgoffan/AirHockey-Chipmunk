//
//  Puck.m
//  AirHockey
//
//  Created by Martin Goffan on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Puck.h"

#define kPosition 0

void updateShape2(void* ptr, void* unused){
    cpShape* shape = (cpShape*)ptr;
    CCSprite* sprite = shape->data;
    if(sprite){
        cpBody* body = shape->body;
        [sprite setPosition:cpv(body->p.x, body->p.y)];
    }
}

@implementation Puck

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    [delegate puck:self receivedTouch:touch withEvent:event];
    NSLog(@"aa");
    
    prevLocation = [touch locationInView:[touch view]];
    return YES;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"aa");
    if (CGRectContainsPoint(self.boundingBox, [[[touches allObjects] objectAtIndex:0] locationInView:[[[touches allObjects] objectAtIndex:0] view]])) {
        NSLog(@"aaaa");
    }
    
    
    [delegate puck:self touchesMoved:touches withEvent:event];
    CGPoint aNewLocation;
    if ([[[touches allObjects] objectAtIndex:0] locationInView:[[[touches allObjects] objectAtIndex:0] view]].y > prevLocation.y) {
        prevLocation = aNewLocation;
        
        NSLog(@"%f",space->gravity.y);
        
        space->gravity = cpv(0, space->gravity.y-=100);
    }
}

-(void)tick:(ccTime)dt{
    cpSpaceStep(space, 1.0f/60.0f);
    cpSpaceHashEach(space->activeShapes, &updateShape2, nil);
}

-(void)setupChipmunk{
    cpInitChipmunk();
    space = cpSpaceNew();
    space->gravity = cpv(0, -100);
    space->elasticIterations = 1;
    [self schedule: @selector(tick:) interval: 1.0f/60.0f];
    cpBody* ballBody = cpBodyNew(200.0, INFINITY);
    ballBody->p = v;
    cpSpaceAddBody(space, ballBody);
    cpShape* ballShape = cpCircleShapeNew(ballBody, 20.0, cpvzero);
    ballShape->e = 1.0;
    ballShape->u = 10000.0;
    ballShape->data = puckSprite;
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

- (id)initWithPosition:(CGPoint)position size:(CGSize)size {
    self = [super init];
    if (nil != self) {
        puckSprite = [CCSprite spriteWithFile:@"puck.png"];
        [puckSprite setPosition:position];
        v = cpv(position.x, position.y);
        [puckSprite setContentSize:size];
        [self addChild:puckSprite];
        [self setupChipmunk];
    }
    return self;
}

-(id)init{
    self = [super init];
    if(nil != self){
        
    }
    return self;
}

@end
