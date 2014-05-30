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
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimers:) userInfo:nil repeats:YES];
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
    [self.view addSubview:newCircle];
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
