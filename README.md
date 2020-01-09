
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

### flutter

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
### ANDROID

This plugin is written in Kotlin. Therefore, you need to add Kotlin support to your project

### IOS

To use on iOS, you must add the the camera usage description to your Info.plist
```groovy
  <key>NSCameraUsageDescription</key>
  <string>Camera permission is required for barcode scanning.</string>
```

### FUNCTION

1.check torch state
2.open or close torch
3.restartScan after scan complete
4.waitting for more

### ATTENTION

his example is using camera ,please accept permission before use this plugin and test example

### IMAGE_PRWIEW
![image](https://github.com/zack-zjc/flutter_qrcode/blob/master/image/capture.jpg?raw=true)
