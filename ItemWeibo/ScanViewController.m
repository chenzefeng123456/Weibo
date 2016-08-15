//
//  ScanViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/15.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    NSTimer *timer;
}
@property(nonatomic,strong) AVCaptureDevice *device;
@property(nonatomic,strong) AVCaptureDeviceInput *input;
@property(nonatomic,strong) AVCaptureMetadataOutput *output;
@property(nonatomic,strong) AVCaptureSession *session;
@property(nonatomic,strong) AVCaptureVideoPreviewLayer *preview;
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCamera];
}
- (void)setupCamera
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        // Device
//        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:nil];
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // Input
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        
        // Output
        _output = [[AVCaptureMetadataOutput alloc]init];
        //    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // Session
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input])
        {
            [_session addInput:self.input];
        }
        
        if ([_session canAddOutput:self.output])
        {
            [_session addOutput:self.output];
        }
        
        // 条码类型 AVMetadataObjectTypeQRCode
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            // Preview
            _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
            _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
            //    _preview.frame =CGRectMake(20,110,280,280);
            _preview.frame = self.view.bounds;
            [self.view.layer insertSublayer:self.preview atIndex:0];
            // Start
            [_session startRunning];
        });
    });
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_session && ![_session isRunning]) {
        [_session startRunning];
    }
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    [timer invalidate];
    NSLog(@"stringValue = %@",stringValue);
    NSURL *url = [NSURL URLWithString:stringValue];
    NSLog(@"url = %@",url);
    if ([url.host isEqualToString:@""]) {
        
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringValue]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
