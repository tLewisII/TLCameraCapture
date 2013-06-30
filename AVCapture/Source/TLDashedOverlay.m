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
//    //// Color Declarations
//    UIColor* fillColor2 = [UIColor colorWithRed: 0.5 green: 0.5 blue: 0.5 alpha: 1];
//    
//    
//    
//    //// swipeArrow Drawing
//    UIBezierPath* swipeArrowPath = [UIBezierPath bezierPath];
//    [swipeArrowPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 120, CGRectGetMinY(frame))];
//    [swipeArrowPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 160, CGRectGetMinY(frame) + 10)];
//    [swipeArrowPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 200, CGRectGetMinY(frame))];
//    [fillColor2 setStroke];
//    swipeArrowPath.lineWidth = 5;
//    [swipeArrowPath stroke];
}
@end
