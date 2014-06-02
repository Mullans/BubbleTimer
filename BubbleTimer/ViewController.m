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
@synthesize timer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTimers:) userInfo:nil repeats:YES];
    //sets background image
//    NSURL *imgUrl=[[NSURL alloc] initWithString:@"http://cdn.osxdaily.com/wp-content/uploads/2010/06/ipad-background-2.jpg"];
//    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
//    UIImage *img = [UIImage imageWithData:imgData];
//    imageView = [[UIImageView alloc] initWithImage:img];
    
    UIImage *testImage = [UIImage imageNamed:@"sky.png"];
    imageView = [[UIImageView alloc] initWithImage:testImage];

    totalBubbles = [[NSMutableArray alloc] initWithCapacity:1];
    toRemove = [[NSMutableArray alloc] initWithCapacity:1];
    [self.view addSubview:imageView ];
    [self.view sendSubviewToBack:imageView ];
    
    //set a gesture recognizer for single taps in the main view
    oneFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTapDetected:)];
    oneFingerTap.numberOfTapsRequired=1;
    oneFingerTap.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:oneFingerTap];
    
    //set a gesture recognizer for double taps in the main view
    doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapDetected:)];
    doubleTap.numberOfTapsRequired=2;
    doubleTap.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:doubleTap];
    
    longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapDetected:)];
    longTap.minimumPressDuration = .5;
    longTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:longTap];

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
    
    for (iOSCircle *circle in totalBubbles){
        if(CGRectContainsPoint(circle.frame, tapPoint)){
            [circle tapBubble];
            return;
        }
    }
    
    NSInteger thisBubbleSize = random()%20 + BUBBLESIZE-10;
    NSLog(@"%li",(long)thisBubbleSize);
    // Create a new iOSCircle Object
    CGRect circleFrame = CGRectMake(tapPoint.x-thisBubbleSize/2,tapPoint.y-thisBubbleSize/2,thisBubbleSize,thisBubbleSize);
    iOSCircle *newCircle = [[iOSCircle alloc]initStopwatch:circleFrame];
    newCircle.circleCenter = tapPoint;
    // Set a random Circle Radius in the future
    newCircle.circleRadius = thisBubbleSize;
    newCircle.opaque = false;
    // Add the Circle Object to the Array
    [totalBubbles addObject:newCircle];
    // update the view
    newCircle.userInteractionEnabled = YES;
    [self.view addSubview:newCircle];
}
-(void)doubleTapDetected:(UIGestureRecognizer*)recognizer{
    tapPoint = [doubleTap locationInView:self.view];
    for(iOSCircle *circle in totalBubbles){
        if(CGRectContainsPoint(circle.frame, tapPoint)){
            [circle removeFromSuperview];
            [toRemove addObject:circle];
        }
    }
}
-(void)longTapDetected:(UILongPressGestureRecognizer*)recognizer{
    NSLog(@"longTouch");
    tapPoint = [longTap locationInView:self.view];
    if(recognizer.state == UIGestureRecognizerStateEnded){
        for (iOSCircle *circle in totalBubbles){
            if(CGRectContainsPoint(circle.frame, tapPoint)){
                return;
            }
        }
        NSInteger thisBubbleSize = random()%20 + BUBBLESIZE-10;
        NSLog(@"%li",(long)thisBubbleSize);
        // Create a new iOSCircle Object
        CGRect circleFrame = CGRectMake(tapPoint.x-thisBubbleSize/2,tapPoint.y-thisBubbleSize/2,thisBubbleSize,thisBubbleSize);
        
        //use UIPopover to get desired time
        
        iOSCircle *newCircle = [[iOSCircle alloc]initTimer:circleFrame Time:30];
        newCircle.circleCenter = tapPoint;
        // Set a random Circle Radius in the future
        newCircle.circleRadius = thisBubbleSize;
        newCircle.opaque = false;
        // Add the Circle Object to the Array
        [totalBubbles addObject:newCircle];
        // update the view
        newCircle.userInteractionEnabled = YES;
        [self.view addSubview:newCircle];
    }else if(recognizer.state ==UIGestureRecognizerStateBegan){
        for (iOSCircle *circle in totalBubbles){
            if(CGRectContainsPoint(circle.frame, tapPoint)){
                [circle tapBubble];
                return;
            }
        }
    }
}

-(void)updateTimers:(NSTimer *)theTimer{
    if([toRemove count]!=0){
        for(iOSCircle* circle in toRemove){
            [totalBubbles removeObject:circle];
        }
    }
    for(iOSCircle* circle in totalBubbles){
        [circle updateCounter];
    }
}


@end
