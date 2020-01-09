#import "FlutterQrcodePlugin.h"
#import <flutter_qrcode/flutter_qrcode-Swift.h>
 #import "QRFactory.h"

@implementation FlutterQrcodePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [SwiftFlutterQrcodePlugin registerWithRegistrar:registrar];
    [registrar registerViewFactory:[[QRFactory alloc] initWithRegistrar:registrar] withId:@"iOS/scanQrCodeView"];
}
@end
