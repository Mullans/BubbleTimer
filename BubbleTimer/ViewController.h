//
//  ViewController.h
//  BubbleTimer
//
//  Created by Sean on 5/26/14.
//  Copyright (c) 2014 SilentLupin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iOSCircle.h"
#import "TimerPicker.h"
#define MINRADIUS 10
#define MAXRADIUS 30
#define BUBBLESIZE 80

@interface ViewController : UIViewController{
    UIImageView *imageView;
    UITapGestureRecognizer *oneFingerTap;
    UITapGestureRecognizer *doubleTap;
    UILongPressGestureRecognizer *longTap;
    CGPoint tapPoint;
    NSMutableArray *totalBubbles;
    NSMutableArray *toRemove;
    NSTimer* timer;
    NSDate* date;
    bool pause;
}
@property (nonatomic, strong) TimerPicker *timerPicker;
@property (retain,nonatomic) NSTimer *timer;
@property (nonatomic, strong) UIPopoverController *timerPopoverController;

-(void)updateTimers: (NSTimer*)theTimer;
-(void)addBackground;
@end
