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
@synthesize circleCenter,circleRadius,secondsPassed;

- (id)initWithFrame:(CGRect)frame Radius:(int)radius
{
    self = [super initWithFrame:frame];
    self.opaque = true;
    self.backgroundColor = ([UIColor colorWithWhite:0.0 alpha:0.0]);
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
    [self setBackgroundColor:self.backgroundColor = ([UIColor colorWithWhite:0.0 alpha:0.0])];
    CGContextAddArc(context, circleRadius/2, circleRadius/2, circleRadius/2-circleStroke, 0.0, M_PI * 2.0, YES);
    // Draw
    CGContextStrokePath(context);
        NSLog(@"%f, %f",self.circleCenter.x,self.circleCenter.y);
    self.layer.cornerRadius = 0;
    self.center = circleCenter;
    
    _time = [[UILabel alloc] initWithFrame:CGRectMake(circleRadius/2-27, circleRadius/2-10,120,20)];
    _time.text = @"00:00:00";
    [_time setTextColor:[UIColor blueColor]];
//    [_time setBackgroundColor:[UIColor clearColor]];
    [_time setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
    //        [self.time setTextAlignment:NSTextAlignmentCenter];
    //_time.center = self.center;
    [self addSubview:_time];
//    [self bringSubviewToFront:_time];
}
-(void)updateTime:(NSString *)newTime{
    [_time removeFromSuperview];
    _time.text = newTime;
    [self addSubview:_time];
}


@end