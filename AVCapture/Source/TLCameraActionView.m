//
//  TLCameraActionView.m
//  AVCapture
//
//  Created by Terry Lewis II on 7/1/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TLCameraActionView.h"
#import <QuartzCore/QuartzCore.h>
@interface TLCameraActionView()
@property(strong,nonatomic)UIButton *cancelButton;
@end
@implementation TLCameraActionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.takePictureButton = [[TLPictureButton alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.bounds) - (80 / 2), CGRectGetMidY(self.bounds)- (80 / 2) , 80, 80)];
        [self addSubview:self.takePictureButton];
        self.backgroundColor = [UIColor blackColor];
        self.alpha = .9;
    }
    return self;
}

@end
