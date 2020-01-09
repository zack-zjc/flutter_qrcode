//
//  HBK_ScanViewController.h
//  HBK_Scan
//
//  Created by 黄冰珂 on 2017/11/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBK_ScanViewController : UIViewController
@property (nonatomic, copy) void (^scanResult)(NSString *result);

- (void)setupScanningQRCode;
- (void)turnOnLight:(BOOL)on;
- (BOOL)isTorch;
- (void)restartScan;
@end
