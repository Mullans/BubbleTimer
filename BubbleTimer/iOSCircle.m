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

- (id)initStopwatch:(CGRect)frame
{
    myRed = 0;
    myGreen = 1;
    myAlpha = .4;
    timeLeft = 0;
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
-(id)initTimer:(CGRect)frame Time:(int)remaining{
    myAlpha = .4;
    myRed = 0;
    myGreen = 1;
    totalMilliseconds = remaining*100;
    startingTime = remaining*100;
    timeLeft = 1;
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
    [[[UIColor alloc]initWithRed:0 green:0 blue:1 alpha:.5] set];
//    [self setBackgroundColor:self.backgroundColor = ([UIColor colorWithWhite:255 alpha:.4])];
    [self setBackgroundColor:self.backgroundColor = ([UIColor colorWithRed:myRed green:myGreen blue:0 alpha:myAlpha])];
    CGContextAddArc(context, circleRadius/2, circleRadius/2, circleRadius/2-1, 0.0, M_PI * 2.0, YES);
    // Draw
    [self setNeedsDisplay];
    CGContextStrokePath(context);
//    NSLog(@"%f, %f",self.circleCenter.x,self.circleCenter.y);
    self.layer.cornerRadius = circleRadius/2;
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
        if(timeLeft==1){
            totalMilliseconds--;
            if(totalMilliseconds==0){
                inactive= !inactive;
                timeLeft = 0;
                myGreen = 1;
                myRed = 0;
                startingTime = 0;
            }else{
                float percentDone = ((float)startingTime-(float)totalMilliseconds)/(float)startingTime;
                myGreen = 1-percentDone;
                myRed = percentDone;
            }
        }else{
            totalMilliseconds++;
        }
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
    self.backgroundColor = ([UIColor colorWithRed:1 green:0 blue:0 alpha:myAlpha]);
}

@end