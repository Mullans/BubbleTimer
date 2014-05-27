//
//  iOSCircle.m
//  BubbleTimer
//
//  Created by Sean on 5/27/14.
//  Copyright (c) 2014 SilentLupin. All rights reserved.
//

#import "iOSCircle.h"

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
    // Get the Graphics Context
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Set the circle outerline-width
    CGContextSetLineWidth(context, 1.0);
    // Set the circle outerline-colour
    [[UIColor redColor] set];
    
    
    CGContextAddArc(context, 10, 10, self.circleRadius, 0.0, M_PI * 2.0, YES);
    // Draw
    CGContextStrokePath(context);
        NSLog(@"%f, %f",self.circleCenter.x,self.circleCenter.y);
    self.layer.cornerRadius = 10.0;
    self.center = circleCenter;
}


@end