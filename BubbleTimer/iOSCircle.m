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
    myAlpha = .6;
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
    myAlpha = .6;
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
//    int circleStroke = 1.0;
    // Get the Graphics Context
    if(sentinel==0){
        sentinel = 1;
    }else{
        [_time removeFromSuperview];
    }
    context = UIGraphicsGetCurrentContext();
    // Set the circle outerline-width
//    CGContextSetLineWidth(context, circleStroke);
    // Set the circle outerline-colour
    // [[[UIColor alloc]initWithRed:0 green:0 blue:1 alpha:.3] set];
    // CGContextAddArc(context, circleRadius/2, circleRadius/2, circleRadius/2-1, 0.0, M_PI * 2.0, YES);
    
    
    //Generate Radial Gradient
    size_t num_locations = 3;
    CGFloat locations[3] = { 0.0, 0.1, 1.0 };
    CGFloat components[12] = { myRed, myGreen, 0, myAlpha,  // Variant Color
                            myRed*.7, myGreen*.7, 0, myAlpha, //MidPoint
                            1.0, 1.0, 1.0, myAlpha }; // White
    CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef radialGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    CGRect currentBounds = self.bounds;
    CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds));
    CGContextDrawRadialGradient(context, radialGradient, midCenter, circleRadius/2, midCenter, 1.0, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(radialGradient);
    CGColorSpaceRelease(rgbColorspace);
    
    
    // Edit layer mask
    [self setNeedsDisplay];
    CGContextStrokePath(context);
    self.layer.cornerRadius = circleRadius/2;
    self.layer.masksToBounds = YES;
    self.center = circleCenter;
    
    //Add text in center
    _time = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,circleRadius,circleRadius)];
    if(hours==0){
        _time.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    }else{
        _time.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }
    [_time setTextAlignment:NSTextAlignmentCenter];
    [_time setTextColor:[UIColor blueColor]];
    [_time setFont:[UIFont fontWithName: @"TimesNewRomanPS-BoldMT" size: 34.0f]];
    [self addSubview:_time];
    [self bringSubviewToFront:_time];
}

- (void)updateCounter{
    if(!inactive){
        if(timeLeft==1){
            totalMilliseconds-=100;
            if(totalMilliseconds==0){
                inactive= !inactive;
                timeLeft = 0;
                myGreen = 0;
                myRed = 1;
                startingTime = 0;
            }else{
                float percentDone = ((float)startingTime-(float)totalMilliseconds)/(float)startingTime;
                myGreen = 1-percentDone;
                myRed = percentDone;
            }
        }else{
            totalMilliseconds+=100;
        }
        milliseconds = totalMilliseconds%100;
        seconds = (totalMilliseconds/100)%60;
        minutes = (totalMilliseconds/6000)%60;
        hours = (totalMilliseconds/360000);
        [self setNeedsDisplay];
    }
}

-(void)tapBubble{
    NSLog(@"BubbleTapped");
    inactive = !inactive;
//    self.backgroundColor = ([UIColor colorWithRed:1 green:0 blue:0 alpha:myAlpha]);
    if(inactive){
        myRed = 1;
        myGreen = 0;
    }else{
        myRed = 0;
        myGreen = 1;
    }
    NSLog(@"%f  %f",myRed, myGreen);
    [self setNeedsDisplay];
}

@end