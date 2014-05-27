//
//  iOSCircle.h
//  Drawing Circles with UITouch
//
//  Created by Arthur Knopper on 79//12.
//  Copyright (c) 2012 iOSCreator. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface iOSCircle: UIView
@property (nonatomic) CGPoint circleCenter;
@property (nonatomic) float circleRadius;

- (void)drawCircle;


@end