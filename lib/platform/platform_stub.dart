import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;

abstract class Platform {
  bool get isRelease => kReleaseMode;
  bool get isWeb => kIsWeb;
  bool get isCanvasKit;
}

Platform initPlatform() => throw UnimplementedError();
