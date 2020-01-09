//
//  QRFactory.m
//  Runner
//
//  Created by MAC on 2020/1/7.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "QRFactory.h"
#import "QRView.h"

@interface QRFactory ()
@property(nonatomic, strong) NSObject <FlutterPluginRegistrar>* registrarInstance;
@end

@implementation QRFactory
- (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar>*)instance{
    self = [super init];
    if (self) {
        self.registrarInstance = instance;
    }
    return self;
}
- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
        viewIdentifier:(int64_t)viewId
        arguments:(id _Nullable)args{
    QRView *qrView =  [[QRView alloc]initWithFrame:frame viewId:viewId args:args registrarInstance:self.registrarInstance];
    return qrView;
}
@end
