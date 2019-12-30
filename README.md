
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

#控件使用

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

## 效果图
![image](https://github.com/zack-zjc/flutter_qrcode/master/image/capture.jpg?raw=true)