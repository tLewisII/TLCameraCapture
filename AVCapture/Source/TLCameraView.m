//
//  TLCameraView.m
//  AVCapture
//
//  Created by Terry Lewis II on 6/25/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TLCameraView.h"

@interface TLCameraView ()

@end

@implementation TLCameraView
- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMidY(frame) - 160, 320, 420)]) {

    }
    return self;
}

@end
