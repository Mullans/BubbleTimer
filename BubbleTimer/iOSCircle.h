//
//  iOSCircle.h
//  Drawing Circles with UITouch
//
//  Created by Arthur Knopper on 79//12.
//  Copyright (c) 2012 iOSCreator. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface iOSCircle: UIView{
    UILabel* time;
    //possible have a transition to hours?
    int minutes;
    int seconds;
    int hours;
    int totalSeconds;
    NSTimer* innerTimer;
    CGContextRef context;
    int sentinel;
}
@property (nonatomic) CGContextRef context;
@property (nonatomic) CGPoint circleCenter;
@property (nonatomic) float circleRadius;
@property (nonatomic) float secondsPassed;
@property (nonatomic,retain) UILabel* time;
@property (nonatomic,retain) NSTimer* innerTimer;

- (void)drawCircle;
-(void)updateCounter:(NSTimer*) theTimer;
-(void)updateCounter;
@end