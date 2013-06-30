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
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ref, [UIColor blueColor].CGColor);
    CGContextStrokeRect(ref, self.bounds);
}


@end
