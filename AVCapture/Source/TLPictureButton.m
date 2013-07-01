//
//  TLPictureButton.m
//  AVCapture
//
//  Created by Terry Lewis II on 7/1/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TLPictureButton.h"

@implementation TLPictureButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    //// Color Declarations
    UIColor* innerOvalFill = [UIColor colorWithRed: 0.114 green: 0.114 blue: 1 alpha: 1];
    UIColor* outerOvalFill = [UIColor colorWithRed: 0.333 green: 0.333 blue: 0.333 alpha: 1];
    
    //// Frames
    CGRect frame = self.bounds;

    //// outerOval Drawing
    UIBezierPath* outerOvalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(frame) + 2.5, CGRectGetMinY(frame) + 2.5, CGRectGetWidth(frame) - 5, CGRectGetHeight(frame) - 5)];
    [outerOvalFill setFill];
    [outerOvalPath fill];
    [innerOvalFill setStroke];
    outerOvalPath.lineWidth = 1;
    [outerOvalPath stroke];
    
    
    //// innerOval Drawing
    UIBezierPath* innerOvalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(outerOvalPath.bounds) + (3), CGRectGetMinY(outerOvalPath.bounds) + (3), CGRectGetWidth(outerOvalPath.bounds) * .92, CGRectGetHeight(outerOvalPath.bounds) * .92)];
    [innerOvalFill setFill];
    [innerOvalPath fill];
}

@end
