import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterQrCode {
  static const MethodChannel _channel = const MethodChannel('flutter_qrcode');

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
  @override
  State<StatefulWidget> createState() => QrCodeScanViewState();
}

class QrCodeScanViewState extends State<QrCodeScanView> {
  MethodChannel _channel;

  EventChannel _eventChannel;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: "Android/scanQrCodeView",
        onPlatformViewCreated: createdFunction,
        creationParamsCodec: StandardMessageCodec(),
      );
    }
    return Text("no implement");
  }

  void createdFunction(id) {
    _channel = MethodChannel('flutter_qrcode_$id');
    _eventChannel = EventChannel('flutter_qrcode_event_$id');
  }

  //接收扫码结果
  void listenScanResult(void onData(String event)) {
    _eventChannel.receiveBroadcastStream().listen(onData);
  }

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
