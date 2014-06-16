//
//  TimerPicker.m
//  BubbleTimer
//
//  Created by Sean on 6/16/14.
//  Copyright (c) 2014 SilentLupin. All rights reserved.
//

#import "TimerPicker.h"

@implementation TimerPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self start];
    }
    return self;
}

- (void)start
{
    self.dataSource = self;
    self.delegate = self;
    
    UILabel *hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, self.frame.size.height / 2 - 15, 75, 30)];
    hourLabel.text = @"hour";
    [self addSubview:hourLabel];
    
    UILabel *minsLabel = [[UILabel alloc] initWithFrame:CGRectMake(45 + (self.frame.size.width / 3), self.frame.size.height / 2 - 15, 75, 30)];
    minsLabel.text = @"min";
    [self addSubview:minsLabel];
    
    UILabel *secsLabel = [[UILabel alloc] initWithFrame:CGRectMake(45 + ((self.frame.size.width / 3) * 2), self.frame.size.height / 2 - 15, 75, 30)];
    secsLabel.text = @"sec";
    [self addSubview:secsLabel];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
        return 24;
    
    return 60;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 25;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *columnView = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, self.frame.size.width/3 - 35, 20)];
    columnView.text = [NSString stringWithFormat:@"%lu", row];
    columnView.textAlignment = NSTextAlignmentLeft;
    
    return columnView;
}
@end
