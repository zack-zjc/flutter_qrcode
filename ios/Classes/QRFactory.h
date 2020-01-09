//
//  QRFactory.h
//  Runner
//
//  Created by MAC on 2020/1/7.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@interface QRFactory : NSObject<FlutterPlatformViewFactory>
- (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar>*)instance;
@end
