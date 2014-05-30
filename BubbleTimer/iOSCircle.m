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
@synthesize innerTimer;

- (id)initWithFrame:(CGRect)frame Radius:(int)radius
{
    innerTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
    _time.text = @"00:00:00";
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
//    NSLog(@"%f, %f",self.circleCenter.x,self.circleCenter.y);
    self.layer.cornerRadius = 0;
    self.center = circleCenter;
    
    _time = [[UILabel alloc] initWithFrame:CGRectMake(circleRadius/2-27, circleRadius/2-10,120,20)];
    _time.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    [_time setTextColor:[UIColor blueColor]];
//    [_time setBackgroundColor:[UIColor clearColor]];
    [_time setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
    //        [self.time setTextAlignment:NSTextAlignmentCenter];
    //_time.center = self.center;
    [self addSubview:_time];
    [self bringSubviewToFront:_time];
}

- (void)updateCounter:(NSTimer *)theTimer {
    NSLog(@"Tock");
    totalSeconds++;
    seconds = totalSeconds%60;
    minutes = (totalSeconds/60)%60;
    hours = (totalSeconds/3600);
    _time.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    [self setNeedsDisplay];
    NSLog(@"Timer: %@",[NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds]);
}

- (void)updateCounter{
    totalSeconds++;
    seconds = totalSeconds%60;
    minutes = (totalSeconds/60)%60;
    hours = (totalSeconds/3600);
    _time.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    [self setNeedsDisplay];
    NSLog(@"noTimer: %@",[NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds]);
}


@end