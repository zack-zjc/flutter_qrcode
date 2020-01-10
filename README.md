
# flutter_qrcode

A new flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

### FLUTTER

you can depend on the flutter_qrcode plugin in your pubspec.yaml file
```groovy
  dependencies:
    ...
    flutter_qrcode: 
      git: https://github.com/zack-zjc/flutter_qrcode.git
```

### USAGE

```groovy
     QrCodeScanView(
        controllerCallback: (controller) {
          _controller = controller;
        },
        scanCallback: (success, text) {
          if (success) {
             print(text);
             _controller.restartScan();
          }
         },
      )
```

```groovy
  var qrCode = await FlutterQrCode().scanFile(File);
```
### ANDROID

This plugin is written in Kotlin. Therefore, you need to add Kotlin support to your project

This plugin has permission check so no use to request permission before use

### IOS

To use on iOS, you must add the the camera usage description to your Info.plist
```groovy
  <key>NSCameraUsageDescription</key>
  <string>Camera permission is required for barcode scanning.</string>
```

### FUNCTION

1.getQrcodeFromFile(without ui only use methodChannel)

2.check torch state

3.open or close torch

4.restartScan after scan complete

5.check camera permission in android

6.waitting for more


