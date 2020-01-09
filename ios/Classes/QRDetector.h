//
//  QRDetector.h
//  Runner
//
//  Created by MAC on 2020/1/9.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface QRDetector : NSObject
+ (instancetype)shareInstance;
- (void)scanCodeFromFile:(NSString *)path callBack:(void(^)(NSString *obj))result;
@end
