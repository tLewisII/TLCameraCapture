//
//  TLCameraController.h
//  AVCapture
//
//  Created by Terry Lewis II on 6/25/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//
@protocol TLCameraControllerDelegate <NSObject>
@optional
-(void)pictureFromCamera:(UIImage *)image;

@end
#import <UIKit/UIKit.h>

typedef void(^TLCameraPictureBlock)(UIImage *image);
@interface TLCameraController : UIViewController

- (instancetype)initWithDelegate:(id<TLCameraControllerDelegate>)delegate view:(UIView *)view;

- (void)show;

- (void)pictureTaken:(TLCameraPictureBlock)block;
@end

