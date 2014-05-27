//
//  ViewController.m
//  BubbleTimer
//
//  Created by Sean on 5/26/14.
//  Copyright (c) 2014 SilentLupin. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //sets background image
    NSURL *imgUrl=[[NSURL alloc] initWithString:@"http://cdn.osxdaily.com/wp-content/uploads/2010/06/ipad-background-2.jpg"];
    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
    UIImage *img = [UIImage imageWithData:imgData];
    
    imageView = [[UIImageView alloc] initWithImage:img];
    
    [self.view addSubview:imageView ];
    [self.view sendSubviewToBack:imageView ];
    
    //set a gesture recognizer for single taps in the main view
    oneFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTapDetected:)];
    oneFingerTap.numberOfTapsRequired=1;
    oneFingerTap.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:oneFingerTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)oneTapDetected:(UITapGestureRecognizer *)recognizer{
//    NSLog(@"one tap detected");
    tapPoint = [oneFingerTap locationInView:self.view];
//    NSLog(@"%f, %f",tapPoint.x,tapPoint.y);
    
    // Create a new iOSCircle Object
    CGRect circleFrame = CGRectMake(tapPoint.x-BUBBLESIZE/2,tapPoint.y-BUBBLESIZE/2,BUBBLESIZE,BUBBLESIZE);
    iOSCircle *newCircle = [[iOSCircle alloc]initWithFrame:circleFrame];
    // Set the Center of the Circle
    newCircle.circleCenter = tapPoint;
    // Set a random Circle Radius
    newCircle.circleRadius = BUBBLESIZE;
    
    // Add the Circle Object to the Array
    [totalBubbles addObject:newCircle];
    
    // update the view
    [self.view addSubview:newCircle];
    //[self.view setNeedsDisplay];
}

-(void)drawBubble
{
    return;
}



@end
