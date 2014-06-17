//
//  iOSCircle.h
//  Drawing Circles with UITouch
//
//  Created by Arthur Knopper on 79//12.
//  Copyright (c) 2012 iOSCreator. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface iOSCircle: UIView{
//    UILabel* time;
    //possible have a transition to hours?
    int seconds;
    int milliseconds;
    int minutes;
    int hours;
    unsigned int totalMilliseconds;
    CGContextRef context;
    int sentinel;
    bool inactive;
    int timeLeft;
    unsigned int startingTime;
    float myRed,myGreen,myAlpha;
    int draw;
}
@property (nonatomic) CGContextRef context;
@property (nonatomic) CGPoint circleCenter;
@property (nonatomic) float circleRadius;
@property (nonatomic) float secondsPassed;
@property (nonatomic,retain) UILabel* time;
@property (nonatomic) bool inactive;

- (void)drawCircle;
-(void)updateCounter;
-(void)tapBubble;
-(id)initTimer:(CGRect)frame Time:(int)remaining;
-(id)initStopwatch:(CGRect)frame;
@end