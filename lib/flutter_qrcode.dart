import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

typedef void PermissionDenialCallback(String message);
typedef void ScanCallback(bool result, String message);
typedef void ScanViewControllerCreated(QrCodeViewController controller);

class FlutterQrCode {
  static const MethodChannel _channel =
      const MethodChannel('com.qrcode.scan/flutter_qrcode');

  static Future<String> scanFile(File file) async {
    if (file?.existsSync() == false) {
      return null;
    }
    try {
      final rest = await _channel.invokeMethod("getQrCodeFromFile", file.path);
      return rest;
    } catch (e) {
      return null;
    }
  }
}

class QrCodeScanView extends StatefulWidget {
  final ScanViewControllerCreated onViewCreated;

  final ScanCallback scanCallback;

  final PermissionDenialCallback permissionDenialCallback;

  QrCodeScanView(
      {Key key,
      @required this.onViewCreated,
      @required this.scanCallback,
      @required this.permissionDenialCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => QrCodeScanViewState();
}

class QrCodeScanViewState extends State<QrCodeScanView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: "Android/scanQrCodeView",
        onPlatformViewCreated: createdFunction,
        creationParamsCodec: StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: "iOS/scanQrCodeView",
        onPlatformViewCreated: createdFunction,
        creationParamsCodec: StandardMessageCodec(),
      );
    }
    return Text("no implement");
  }

  void createdFunction(id) {
    widget.onViewCreated(QrCodeViewController(
        id, widget.scanCallback, widget.permissionDenialCallback));
  }
}

class QrCodeViewController {
  final int id;
  MethodChannel _channel;
  EventChannel _eventChannel;
  ScanCallback scanCallback;
  PermissionDenialCallback permissionDenialCallback;

  QrCodeViewController(
      this.id, this.scanCallback, this.permissionDenialCallback) {
    _eventChannel = EventChannel('com.qrcode.scan/event_$id');
    _channel = MethodChannel('com.qrcode.scan/channel_$id');
    _eventChannel.receiveBroadcastStream().listen(onScanSuccess,
        onError: onScanError, onDone: onScanFinish, cancelOnError: false);
  }

  void onScanSuccess(Object result) {
    scanCallback(true, result.toString());
  }

  void onScanError(Object result) {
    if (result is PlatformException) {
      if (result.code == "-1") {
        permissionDenialCallback(result.details);
      } else {
        scanCallback(false, result.details);
      }
    }
  }

  void onScanFinish() {}

  // 打开手电筒
  Future<bool> setFlashlightOn() async {
    return _channel.invokeMethod("openTorch");
  }

  // 关闭手电筒
  Future<bool> setFlashlightOff() async {
    return _channel.invokeMethod("closeTorch");
  }

  // 手电筒是否打开
  Future<bool> isFlashlightOn() async {
    return _channel.invokeMethod("isTorchOn");
  }

  // 重新开始扫码
  Future<bool> restartScan() async {
    return _channel.invokeMethod("restartScan");
  }
}
