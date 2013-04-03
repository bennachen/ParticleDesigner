//
//  MainLayer.m
//  ParticleDesigner
//
//  Created by Paul on 11/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainLayer.h"


@implementation MainLayer

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    MainLayer *layer = [MainLayer node];
	layer.tag = 1000;
    [scene addChild: layer];
    return scene;
}

- (id) init
{
    if((self = [self initWithColor:ccc4(0, 0, 0, 255)])) {
		
		/*
		GL_ZERO					0
		GL_ONE					1
		GL_DST_COLOR			0x0306
		GL_ONE_MINUS_DST_COLOR	0x0307
		GL_SRC_ALPHA			0x0302
		GL_ONE_MINUS_SRC_ALPHA	0x0303
		GL_DST_ALPHA			0x0304
		GL_ONE_MINUS_DST_ALPHA	0x0305
		
		GL_SRC_ALPHA_SATURATE	0x0308
		 */
        self.isMouseEnabled = YES;
	}
    return self;
}

- (BOOL) ccMouseDown:(NSEvent *)event
{
//    CGPoint location = [event locationInWindow];
    if ([[self children] count] > 0) {
        MSParticles *msp = (MSParticles *)[[self children] objectAtIndex:0];
        CGPoint touchPoint = [[CCDirectorMac sharedDirector] convertEventToGL:event];
        msp.position = touchPoint;
    }
    
    return YES;
}

- (BOOL) ccMouseMoved:(NSEvent *)event
{
    return YES;
}

- (BOOL) ccMouseUp:(NSEvent *)event
{
    
    return YES;
}

- (void) dealloc
{
    [super dealloc];
}

@end
