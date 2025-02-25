import 'package:flutter_common/platform/platform_stub.dart';

IoPlatform? instance;

class IoPlatform extends Platform {
  @override
  bool get isCanvasKit => false;
}

IoPlatform initPlatform() {
  instance ??= IoPlatform();
  return instance!;
}
