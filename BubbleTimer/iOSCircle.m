//
//  iOSCircle.m
//  BubbleTimer
//
//  Created by Sean on 5/27/14.
//  Copyright (c) 2014 SilentLupin. All rights reserved.
//

#import "iOSCircle.h"
#import "ViewController.h"

@implementation iOSCircle
@synthesize circleCenter,circleRadius;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.opaque = false;
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [self drawCircle];
}

- (void)drawCircle
{
    int circleStroke = 2.0;
    // Get the Graphics Context
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Set the circle outerline-width
    CGContextSetLineWidth(context, circleStroke);
    // Set the circle outerline-colour
    [[UIColor blueColor] set];
    
    CGContextAddArc(context, BUBBLESIZE/2, BUBBLESIZE/2, BUBBLESIZE/2-circleStroke, 0.0, M_PI * 2.0, YES);
    // Draw
    CGContextStrokePath(context);
        NSLog(@"%f, %f",self.circleCenter.x,self.circleCenter.y);
    self.layer.cornerRadius = 10.0;
    self.center = circleCenter;
}


@end