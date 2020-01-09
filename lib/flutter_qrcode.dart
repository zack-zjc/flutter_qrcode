import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

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
  final Function(QrCodeViewController) controllerCallback;

  final Function(bool, String) scanCallback;

  QrCodeScanView({Key key, this.controllerCallback, this.scanCallback})
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
    widget.controllerCallback(QrCodeViewController(id, widget.scanCallback));
  }
}

class QrCodeViewController {
  final int id;
  MethodChannel _channel;
  EventChannel _eventChannel;
  Function(bool, String) scanCallback;

  QrCodeViewController(this.id, this.scanCallback) {
    _eventChannel = EventChannel('com.qrcode.scan/event_$id');
    _channel = MethodChannel('com.qrcode.scan/channel_$id');
    _eventChannel.receiveBroadcastStream().listen(onScanSuccess,
        onError: onScanError, onDone: onScanFinish, cancelOnError: false);
  }

  void onScanSuccess(Object result) {
    scanCallback(true, result.toString());
  }

  void onScanError(Object result) {
    scanCallback(false, "");
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
