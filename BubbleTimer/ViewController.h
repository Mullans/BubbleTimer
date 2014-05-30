//
//  ViewController.h
//  BubbleTimer
//
//  Created by Sean on 5/26/14.
//  Copyright (c) 2014 SilentLupin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iOSCircle.h"
#define MINRADIUS 10
#define MAXRADIUS 30
#define BUBBLESIZE 80

@interface ViewController : UIViewController{
    UIImageView *imageView;
    UITapGestureRecognizer *oneFingerTap;
    CGPoint tapPoint;
    NSMutableArray *totalBubbles;
}

-(void)drawBubble;

@end
