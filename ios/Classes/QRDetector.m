//
//  QRDetector.m
//  Runner
//
//  Created by MAC on 2020/1/9.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "QRDetector.h"

@implementation QRDetector
static  QRDetector *_manager;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[QRDetector alloc]init];
    });
    return _manager;
}
- (void)scanCodeFromFile:(NSString *)path callBack:(void(^)(NSString *obj))result{
    NSData *data = [NSData dataWithContentsOfFile:path];
    CIImage *ciimage = [[CIImage alloc]initWithData:data];
    NSDictionary *option = @{CIDetectorAccuracy:CIDetectorAccuracyLow};
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:option];
    NSArray<CIFeature *> *feature = [detector featuresInImage:ciimage options:nil];
    [feature enumerateObjectsUsingBlock:^(CIFeature * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CIQRCodeFeature class]]) {
            CIQRCodeFeature *qrCode = (CIQRCodeFeature *)obj;
            result(qrCode.messageString);
            *stop = YES;
        }
    }];
}
@end
