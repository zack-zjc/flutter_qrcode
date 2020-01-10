import Flutter
import UIKit

public class SwiftFlutterQrcodePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.qrcode.scan/flutter_qrcode", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterQrcodePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getQrCodeFromFile" {
        let path = call.arguments! as! String
        QRDetector.shareInstance()?.scanCode(fromFile: path, callBack: { (string) in
            result(string)
        })
    } else {
        result(nil)
    }
  }
}
