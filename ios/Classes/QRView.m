//
//  QRView.m
//  Runner
//
//  Created by MAC on 2020/1/7.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "QRView.h"
#import "HBK_ScanViewController.h"

@interface QRView ()<FlutterStreamHandler>

@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) long long viewId;
@property(nonatomic, strong) NSObject<FlutterPluginRegistrar>* registrar;
@property(nonatomic, strong) HBK_ScanViewController *scanViewController;
@property(nonatomic, copy) FlutterEventSink sink;
@end

@implementation QRView
/*
 (_ frame: CGRect, viewId: Int64, args: Any?, registrarInstance : FlutterPluginRegistrar)
 */
- (instancetype)initWithFrame:(CGRect)frame viewId:(long long)viewId args:(id)args registrarInstance:(NSObject<FlutterPluginRegistrar>*)registrar{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.viewId = viewId;
        self.registrar = registrar;
        FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:[NSString stringWithFormat:@"com.qrcode.scan/channel_%lld",self.viewId] binaryMessenger:self.registrar.messenger];
        __weak  typeof(self) weakself = self;

        [channel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
            SEL  method = NSSelectorFromString(call.method);
            [weakself performSelector:method];
        }];
        FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:[NSString stringWithFormat:@"com.qrcode.scan/event_%lld",self.viewId] binaryMessenger:self.registrar.messenger];
        [eventChannel setStreamHandler:self];
  
    }
    return self;
    
}
- (HBK_ScanViewController *)scanViewController{
    if (!_scanViewController) {
        _scanViewController = [[HBK_ScanViewController alloc]init];
        __weak  typeof(self) weakself = self;
        [_scanViewController setScanResult:^(NSString *result) {
            weakself.sink(result);
        }];
    }
    return _scanViewController;
}
- (UIView*)view{
    self.scanViewController.view.frame = self.frame;
    [self.scanViewController setupScanningQRCode];
    return self.scanViewController.view;
}
- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events{
    self.sink = events;
    return  nil;
}
- (FlutterError *)onCancelWithArguments:(id)arguments{
    return nil;
}
- (BOOL)openTorch{
    [self.scanViewController turnOnLight:YES];
    return YES;
}
- (BOOL)closeTorch{
    [self.scanViewController turnOnLight:NO];
    return YES;
}
- (BOOL)isTorchOn{
    
    return  [self.scanViewController isTorch];
}
- (BOOL)restartScan{
    [self.scanViewController restartScan];
    return YES;
}

@end
