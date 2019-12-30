#import "FlutterQrcodePlugin.h"
#import <flutter_qrcode/flutter_qrcode-Swift.h>

@implementation FlutterQrcodePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterQrcodePlugin registerWithRegistrar:registrar];
}
@end
