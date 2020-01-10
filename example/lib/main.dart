import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_qrcode/flutter_qrcode.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  QrCodeViewController _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Stack(
          children: <Widget>[
            QrCodeScanView(
              onViewCreated: (controller) {
                _controller = controller;
              },
              scanCallback: (success, text) {
                if (success) {
                  print(text);
                  _controller.restartScan();
                }
              },
              permissionDenialCallback: (message) {},
            ),
            GestureDetector(
              child: Text(
                "打开闪光灯",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                _controller.setFlashlightOn();
              },
            )
          ],
        ),
      ),
    );
  }
}
