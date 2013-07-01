//
//  TLDashedOverlay.m
//  AVCapture
//
//  Created by Terry Lewis II on 6/25/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TLDashedOverlay.h"

@implementation TLDashedOverlay
- (void)drawRect:(CGRect)rect {
    //// Color Declarations
    UIColor *strokeColor = [UIColor grayColor];

    //// Frames
    CGRect frame = self.bounds;

    //// Bezier Drawing
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(frame) + 2, CGRectGetMidY(frame))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(frame), CGRectGetMidY(frame))];
    [strokeColor setStroke];
    bezierPath.lineWidth = 1;
    CGFloat bezierPattern[] = {4, 4, 4, 4};
    [bezierPath setLineDash:bezierPattern count:4 phase:0];
    [bezierPath stroke];
    
    //// swipeArrow Drawing
    UIBezierPath* swipeArrowPath = [UIBezierPath bezierPath];
    [swipeArrowPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 135, CGRectGetMinY(frame) + 2)];
    [swipeArrowPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 160, CGRectGetMinY(frame) + 8)];
    [swipeArrowPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 185, CGRectGetMinY(frame) + 2)];
    [strokeColor setStroke];
    swipeArrowPath.lineWidth = 5;
    [swipeArrowPath stroke];
}
@end
