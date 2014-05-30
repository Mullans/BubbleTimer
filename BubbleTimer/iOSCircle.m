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
@synthesize context,inactive;

- (id)initWithFrame:(CGRect)frame Radius:(int)radius
{
    inactive = false;
    _time.text = @"00:00:00";
    sentinel = 0;
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
    if(sentinel==0){
        sentinel = 1;
    }else{
        [_time removeFromSuperview];
    }
    context = UIGraphicsGetCurrentContext();
    // Set the circle outerline-width
    CGContextSetLineWidth(context, circleStroke);
    // Set the circle outerline-colour
    [[UIColor blueColor] set];
//    [self setBackgroundColor:self.backgroundColor = ([UIColor colorWithWhite:255 alpha:.4])];
    [self setBackgroundColor:self.backgroundColor = ([UIColor colorWithRed:0 green:1 blue:0 alpha:.5])];
    CGContextAddArc(context, circleRadius/2, circleRadius/2, circleRadius/2, 0.0, M_PI * 2.0, YES);
    // Draw
    [self setNeedsDisplay];
    CGContextStrokePath(context);
//    NSLog(@"%f, %f",self.circleCenter.x,self.circleCenter.y);
    self.layer.cornerRadius = circleRadius/2-1;
    self.layer.masksToBounds = YES;
    self.center = circleCenter;
    _time = [[UILabel alloc] initWithFrame:CGRectMake(circleRadius/2-27, circleRadius/2-10,120,20)];
    _time.text = [NSString stringWithFormat:@"%02d:%02d.%02d", minutes, seconds, milliseconds];
    [_time setTextColor:[UIColor blueColor]];
//    [_time setBackgroundColor:[UIColor clearColor]];
    [_time setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
    //        [self.time setTextAlignment:NSTextAlignmentCenter];
    //_time.center = self.center;
    [self addSubview:_time];
    [self bringSubviewToFront:_time];
}

- (void)updateCounter{
    if(!inactive){
        totalMilliseconds++;
        milliseconds = totalMilliseconds%100;
        seconds = (totalMilliseconds/100)%60;
        minutes = (totalMilliseconds/6000);
//        _time.text = [NSString stringWithFormat:@"%02d:%02d.%02d", hours, minutes, seconds];
        [self setNeedsDisplay];
    }
}

-(void)tapBubble{
    NSLog(@"BubbleTapped");
    inactive = !inactive;
    self.backgroundColor = ([UIColor colorWithRed:1 green:0 blue:0 alpha:.5]);
}

@end