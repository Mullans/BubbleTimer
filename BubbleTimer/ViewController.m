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
    NSURL *imgUrl=[[NSURL alloc] initWithString:@"http://cdn.osxdaily.com/wp-content/uploads/2010/06/ipad-background-2.jpg"];
    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
    UIImage *img = [UIImage imageWithData:imgData];
    imageView = [[UIImageView alloc] initWithImage:img];
    totalBubbles = [[NSMutableArray alloc] initWithCapacity:1];
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
    iOSCircle *newCircle = [[iOSCircle alloc]initWithFrame:circleFrame];
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
            [totalBubbles removeObject:circle];
            [circle removeFromSuperview];
        }
    }
}

-(void)drawBubble
{
    return;
}

-(void)updateTimers:(NSTimer *)theTimer{
    for(iOSCircle* circle in totalBubbles){
        [circle updateCounter];
    }
}



@end
