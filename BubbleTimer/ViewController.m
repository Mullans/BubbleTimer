//
//Pinch to resize bubble?
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

- (void)viewDidLoad{
    [super viewDidLoad];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTimers:) userInfo:nil repeats:YES];

    [self addBackground];

    totalBubbles = [[NSMutableArray alloc] initWithCapacity:1];
    toRemove = [[NSMutableArray alloc] initWithCapacity:1];
    
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
- (void)didReceiveMemoryWarning{
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
//    NSLog(@"longTouch");
    tapPoint = [longTap locationInView:self.view];
    if(recognizer.state == UIGestureRecognizerStateEnded){
        for (iOSCircle *circle in totalBubbles){
            if(CGRectContainsPoint(circle.frame, tapPoint)){
                return;
            }
        }
        
        //use UIPopover to get desired time
        [self makePopover];
    }else if(recognizer.state ==UIGestureRecognizerStateBegan){
        for (iOSCircle *circle in totalBubbles){
            if(CGRectContainsPoint(circle.frame, tapPoint)){
                [circle tapBubble];
                return;
            }
        }
    }
}
-(void)makePopover{
        UIViewController* popoverContent = [[UIViewController alloc] init];
        UIView *popoverView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,236)];
        popoverView.backgroundColor = [UIColor whiteColor];
        
        TimerPicker *timePickerTemp = [[TimerPicker alloc]initWithFrame:CGRectMake(0,30,320,216)];
        self.timerPicker = timePickerTemp;
        [popoverView addSubview: self.timerPicker];
        
        UIToolbar *toolbar = [[UIToolbar alloc] init];
        toolbar.frame=CGRectMake(0,0 ,320, 40);
        toolbar.barStyle = UIBarStyleBlack;
        NSMutableArray *toolbarItems = [NSMutableArray array];
        UIBarButtonItem *cancelButton1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButton)];
        UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButton)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolbarItems addObject:cancelButton1];
        [toolbarItems addObject:space];
        [toolbarItems addObject:doneButton1];
        toolbar.items = toolbarItems;
        [popoverView addSubview:toolbar];
        
        popoverContent.view = popoverView;
        UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
//        popoverController.delegate=self;
        self.timerPopoverController = popoverController;
        
        [self.timerPopoverController setPopoverContentSize:CGSizeMake(320, 236) animated:NO];
        [self.timerPopoverController presentPopoverFromRect:CGRectMake(tapPoint.x,tapPoint.y,1,1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)cancelButton{
    [self.timerPopoverController dismissPopoverAnimated:true];
}
-(void)saveButton{
    
    NSInteger hours = [self.timerPicker selectedRowInComponent:0];
    NSInteger minutes = [self.timerPicker selectedRowInComponent:1];
    NSInteger seconds = [self.timerPicker selectedRowInComponent:2];
    int totalTime = seconds+minutes*60+hours*3600;
    NSInteger thisBubbleSize = random()%20 + BUBBLESIZE-10;
    // Create a new iOSCircle Object
    CGRect circleFrame = CGRectMake(tapPoint.x-thisBubbleSize/2,tapPoint.y-thisBubbleSize/2,thisBubbleSize,thisBubbleSize);
    iOSCircle *newCircle = [[iOSCircle alloc]initTimer:circleFrame Time:totalTime];
    newCircle.circleCenter = tapPoint;
    // Set a random Circle Radius in the future
    newCircle.circleRadius = thisBubbleSize;
    newCircle.opaque = false;
    // Add the Circle Object to the Array
    [totalBubbles addObject:newCircle];
    // update the view
    newCircle.userInteractionEnabled = YES;
    [self.view addSubview:newCircle];
    
    [self.timerPopoverController dismissPopoverAnimated:true];
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
-(void)addBackground{
    
    UIImage *backgroundImage = [UIImage imageNamed:@"universe.png"];
    imageView = [[UIImageView alloc] initWithImage:backgroundImage];
    float imgFactor = imageView.frame.size.height / imageView.frame.size.width;
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;//imageView.frame.size.width * imgFactor;
    NSLog(@"width:%f  height:%f",width,height);
    [imageView setFrame:CGRectMake(0, 0,height,width)];
    [self.view addSubview:imageView ];
    [self.view sendSubviewToBack:imageView ];
}

@end
