//
//  TLFocusView.m
//  AVCapture
//
//  Created by Terry Lewis II on 6/25/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TLFocusView.h"

@implementation TLFocusView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.114 green: 0.114 blue: 1 alpha: 1];
    
    //// Frames
    CGRect frame = self.bounds;
    
    
    //// Group
    {
        //// topLeft Drawing
        UIBezierPath* topLeftPath = [UIBezierPath bezierPath];
        [topLeftPath moveToPoint: CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame))];
        [topLeftPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 5, CGRectGetMinY(frame) + 5) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 4.17, CGRectGetMinY(frame) + 4.17) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 5, CGRectGetMinY(frame) + 5)];
        [color setStroke];
        topLeftPath.lineWidth = 1;
        [topLeftPath stroke];
        
        
        //// topRight Drawing
        UIBezierPath* topRightPath = [UIBezierPath bezierPath];
        [topRightPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 100, CGRectGetMinY(frame))];
        [topRightPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 95, CGRectGetMinY(frame) + 5) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 95.83, CGRectGetMinY(frame) + 4.17) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 95, CGRectGetMinY(frame) + 5)];
        [color setStroke];
        topRightPath.lineWidth = 1;
        [topRightPath stroke];
        
        
        //// bottomRight Drawing
        UIBezierPath* bottomRightPath = [UIBezierPath bezierPath];
        [bottomRightPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 95, CGRectGetMinY(frame) + 95)];
        [bottomRightPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 100, CGRectGetMinY(frame) + 100) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 99.17, CGRectGetMinY(frame) + 99.17) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 100, CGRectGetMinY(frame) + 100)];
        [color setStroke];
        bottomRightPath.lineWidth = 1;
        [bottomRightPath stroke];
        
        
        //// bottomLeft Drawing
        UIBezierPath* bottomLeftPath = [UIBezierPath bezierPath];
        [bottomLeftPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 5, CGRectGetMinY(frame) + 95)];
        [bottomLeftPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + 100) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.83, CGRectGetMinY(frame) + 99.17) controlPoint2: CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + 100)];
        [color setStroke];
        bottomLeftPath.lineWidth = 1;
        [bottomLeftPath stroke];
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + 5, CGRectGetMinY(frame) + 5, 90, 90)];
        [color setStroke];
        rectanglePath.lineWidth = 1;
        [rectanglePath stroke];
        
        
        //// leftMiddle Drawing
        UIBezierPath* leftMiddlePath = [UIBezierPath bezierPath];
        [leftMiddlePath moveToPoint: CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + 50)];
        [leftMiddlePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 5, CGRectGetMinY(frame) + 50)];
        [color setStroke];
        leftMiddlePath.lineWidth = 1;
        [leftMiddlePath stroke];
        
        
        //// rightMiddle Drawing
        UIBezierPath* rightMiddlePath = [UIBezierPath bezierPath];
        [rightMiddlePath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 95, CGRectGetMinY(frame) + 50)];
        [rightMiddlePath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 100, CGRectGetMinY(frame) + 50)];
        [color setStroke];
        rightMiddlePath.lineWidth = 1;
        [rightMiddlePath stroke];
    }
    
    



}


@end
