//
//  TLCameraController.h
//  AVCapture
//
//  Created by Terry Lewis II on 6/25/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLCameraController : UIViewController

- (instancetype)initWithDelegate:(UIViewController *)delegate;

- (void)show;

- (void)pictureTaken:(void (^)(UIImage *image))block;
@end

