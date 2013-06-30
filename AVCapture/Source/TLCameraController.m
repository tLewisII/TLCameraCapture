//
//  TLCameraController.m
//  AVCapture
//
//  Created by Terry Lewis II on 6/25/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TLCameraController.h"
#import "TLCameraView.h"
#import "TLFocusView.h"
#import "TLDashedOverlay.h"
#import "UIImage+Resize.h"
#import <AVFoundation/AVFoundation.h>

@interface TLCameraController () <AVCaptureVideoDataOutputSampleBufferDelegate>
@property(strong, nonatomic) UIViewController *delegate;
@property(strong, nonatomic) AVCaptureDeviceInput *device;
@property(strong, nonatomic) AVCaptureVideoDataOutput *output;
@property(strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property(strong, nonatomic) TLCameraView *camView;
@property(strong, nonatomic) AVCaptureSession *session;
@property(strong, nonatomic) TLFocusView *focusView;
@property(strong, nonatomic) AVCaptureStillImageOutput *stillImage;
@property(strong, nonatomic) UIImageView *imageView;
@property(strong, nonatomic) UIButton *takePictureButton;
@property(copy) void(^completionBlock)(UIImage *image);
@end


@implementation TLCameraController
- (instancetype)initWithDelegate:(UIViewController *)delegate {
    self = [super init];
    if(self) {
        self.delegate = delegate;
        self.view.backgroundColor = [UIColor clearColor];
        [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView:)]];

        self.view.frame = CGRectOffset(self.view.frame, 0, 420);
    }
    return self;
}

- (void)setup {
    self.session = [[AVCaptureSession alloc]init];
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    CGRect r = self.view.layer.bounds;
    r.size.height = 320;
    self.previewLayer.frame = r;
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *err;
    self.device = [AVCaptureDeviceInput deviceInputWithDevice:device error:&err];
    [self.session addInput:self.device];
    self.output = [[AVCaptureVideoDataOutput alloc]init];
    [self.session addOutput:self.output];
    dispatch_queue_t serial_queue = dispatch_queue_create("super.queue", NULL);
    [self.output setSampleBufferDelegate:self queue:serial_queue];
    self.stillImage = [[AVCaptureStillImageOutput alloc]init];
    NSDictionary *outputSettings = @{AVVideoCodecKey : AVVideoCodecJPEG};
    [self.stillImage setOutputSettings:outputSettings];
    [self.session addOutput:self.stillImage];
    [self.session startRunning];
    [[NSOperationQueue mainQueue]addOperationWithBlock:^{

        [self.view.layer insertSublayer:self.previewLayer below:self.takePictureButton.layer];
        TLDashedOverlay *over = [[TLDashedOverlay alloc]initWithFrame:self.previewLayer.frame];
        over.backgroundColor = [UIColor clearColor];
        over.layer.backgroundColor = (__bridge CGColorRef)([UIColor clearColor]);
        [self.view addSubview:over];
        [self.previewLayer addSublayer:over.layer];

        [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focus:)]];
        [self.delegate.view addSubview:self.camView];
        AVCaptureDevice *device = [self.device device];
        NSError *err;
        [device lockForConfiguration:&err];
        [device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
        [device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [device unlockForConfiguration];
        CGRect imageFrame = self.previewLayer.frame;
        imageFrame.size.height = 320;
        self.imageView = [[UIImageView alloc]initWithFrame:imageFrame];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:self.imageView];
    }];
}

- (void)takePicture:(UIButton *)sender {
    AVCaptureConnection *videoConnection = nil;
    for(AVCaptureConnection *connection in self.stillImage.connections) {
        for(AVCaptureInputPort *port in [connection inputPorts]) {
            if([[port mediaType]isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if(videoConnection) {break;}
    }
    CATransition *shutterAnimation = [CATransition animation];
    [shutterAnimation setDelegate:self];
    [shutterAnimation setDuration:0.6];
    
    shutterAnimation.timingFunction = UIViewAnimationCurveEaseInOut;
    [shutterAnimation setType:@"cameraIris"];
    [shutterAnimation setValue:@"cameraIris" forKey:@"cameraIris"];
    CALayer *cameraShutter = [[CALayer alloc]init];
    [cameraShutter setBounds:self.previewLayer.bounds];
    [self.previewLayer addSublayer:cameraShutter];
    [self.previewLayer addAnimation:shutterAnimation forKey:@"cameraIris"];
    [self.stillImage captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [[UIImage alloc]initWithData:imageData];

        CGSize size = CGSizeMake(640, 640);
        UIImage *scaledImage = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:size interpolationQuality:kCGInterpolationHigh];

        UIImage *croppedImage = [scaledImage croppedImage:CGRectMake((scaledImage.size.width - size.width) / 2, (scaledImage.size.height - size.height) / 2, size.width, size.height)];
        NSLog(@"%@", [NSValue valueWithCGSize:croppedImage.size]);
        self.imageView.image = croppedImage;
        self.completionBlock(croppedImage);
    }];
}

- (void)pictureTaken:(void (^)(UIImage *image))block {
    self.completionBlock = [block copy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.camView = [[TLCameraView alloc]initWithFrame:self.view.frame];
    self.camView.backgroundColor = [UIColor blackColor];
    self.view = self.camView;
    self.takePictureButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMaxY(self.camView.bounds) - 100, 320, 100)];
    self.takePictureButton.backgroundColor = [UIColor blackColor];
    self.takePictureButton.alpha = .9;
    [self.takePictureButton setTitle:@"Picture" forState:UIControlStateNormal];
    [self.takePictureButton addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.takePictureButton];
    [self.view.layer addSublayer:self.takePictureButton.layer];
    NSBlockOperation *block = [[NSBlockOperation alloc]init];
    __weak id weakSelf = self;
    [block addExecutionBlock:^{
        [weakSelf setup];
    }];
    [[[NSOperationQueue alloc]init] addOperation:block];
}

- (void)panView:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:recognizer.view];
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    if(velocity.y > 0) {
        recognizer.view.center = CGPointMake(recognizer.view.center.x, translation.y + recognizer.view.center.y);
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:.5 animations:^{
            self.view.frame = CGRectOffset(self.view.frame, 0, 450);
        }                completion:^(BOOL finished) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self.session stopRunning];
            });

            [self removeFromParentViewController];
            [self.view removeFromSuperview];
            self.camView = nil;
        }];
    }
}

- (void)focus:(UITapGestureRecognizer *)recog {
    AVCaptureDevice *device = [self.device device];
    NSError *err;
    CGPoint point = [recog locationInView:self.view];
    if(CGRectContainsPoint(self.previewLayer.bounds, point)) {
        if(!self.focusView) {
            self.focusView = [[TLFocusView alloc]initWithFrame:CGRectMake(point.x, point.y, 75, 75)];
            [self.view addSubview:self.focusView];
            [self.view.layer addSublayer:self.focusView.layer];
        }
        else {
            self.focusView.frame = CGRectMake(point.x, point.y, 75, 75);
        }
        if([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus] && [device isExposurePointOfInterestSupported] && [device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
            BOOL lock = [device lockForConfiguration:&err];
            if(lock) {
                [device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
                [device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
                [device setExposurePointOfInterest:[self convertToPointOfInterestFromViewCoordinates:point]];
                [device setFocusPointOfInterest:[self convertToPointOfInterestFromViewCoordinates:point]];
                [device unlockForConfiguration];
            }
        }
    }
}

- (void)show {
    [self.delegate addChildViewController:self];
    [self.delegate.view addSubview:self.view];
    [UIView animateWithDuration:1 animations:^{
        self.view.frame = CGRectOffset(self.view.frame, 0, -420);
    }];
}

- (CGPoint)convertToPointOfInterestFromViewCoordinates:(CGPoint)viewCoordinates {
    CGPoint pointOfInterest = CGPointMake(.5f, .5f);
    CGSize frameSize = self.camView.frame.size;

    AVCaptureVideoPreviewLayer *videoPreviewLayer = self.previewLayer;


    if([[videoPreviewLayer videoGravity]isEqualToString:AVLayerVideoGravityResize]) {
        pointOfInterest = CGPointMake(viewCoordinates.y / frameSize.height, 1.f - (viewCoordinates.x / frameSize.width));
    } else {
        CGRect cleanAperture;
        for(AVCaptureInputPort *port in [[self.session.inputs lastObject]ports]) {
            if([port mediaType] == AVMediaTypeVideo) {
                cleanAperture = CMVideoFormatDescriptionGetCleanAperture([port formatDescription], YES);
                CGSize apertureSize = cleanAperture.size;
                CGPoint point = viewCoordinates;

                CGFloat apertureRatio = apertureSize.height / apertureSize.width;
                CGFloat viewRatio = frameSize.width / frameSize.height;
                CGFloat xc = .5f;
                CGFloat yc = .5f;

                if([[videoPreviewLayer videoGravity]isEqualToString:AVLayerVideoGravityResizeAspect]) {
                    if(viewRatio > apertureRatio) {
                        CGFloat y2 = frameSize.height;
                        CGFloat x2 = frameSize.height * apertureRatio;
                        CGFloat x1 = frameSize.width;
                        CGFloat blackBar = (x1 - x2) / 2;
                        if(point.x >= blackBar && point.x <= blackBar + x2) {
                            xc = point.y / y2;
                            yc = 1.f - ((point.x - blackBar) / x2);
                        }
                    } else {
                        CGFloat y2 = frameSize.width / apertureRatio;
                        CGFloat y1 = frameSize.height;
                        CGFloat x2 = frameSize.width;
                        CGFloat blackBar = (y1 - y2) / 2;
                        if(point.y >= blackBar && point.y <= blackBar + y2) {
                            xc = ((point.y - blackBar) / y2);
                            yc = 1.f - (point.x / x2);
                        }
                    }
                } else if([[videoPreviewLayer videoGravity]isEqualToString:AVLayerVideoGravityResizeAspectFill]) {
                    if(viewRatio > apertureRatio) {
                        CGFloat y2 = apertureSize.width * (frameSize.width / apertureSize.height);
                        xc = (point.y + ((y2 - frameSize.height) / 2.f)) / y2;
                        yc = (frameSize.width - point.x) / frameSize.width;
                    } else {
                        CGFloat x2 = apertureSize.height * (frameSize.height / apertureSize.width);
                        yc = 1.f - ((point.x + ((x2 - frameSize.width) / 2)) / x2);
                        xc = point.y / frameSize.height;
                    }

                }

                pointOfInterest = CGPointMake(xc, yc);
                break;
            }
        }
    }

    return pointOfInterest;
}
@end
