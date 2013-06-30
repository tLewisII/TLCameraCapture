//
//  TLViewController.m
//  AVCapture
//
//  Created by Terry Lewis II on 6/18/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TLViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TLFocusView.h"
#import "TLCameraController.h"
@interface TLViewController () 
@property(strong,nonatomic)TLCameraController *camera;
@end

@implementation TLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doStuff:)]];

}
-(void)doStuff:(UITapGestureRecognizer *)r {
    self.camera = [[TLCameraController alloc]initWithDelegate:self];
    [self.camera show];
    [self.camera pictureTaken:^(UIImage *image) {
        NSLog(@"%@",@(image != nil));
        NSLog(@"DFHSDGSG");
    }];
}
-(void)pictureFromCamera:(UIImage *)image {
    
}

@end
