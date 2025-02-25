// this issue is fixed by conditionally importing platform:
// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:js';

import 'package:flutter_common/platform/platform_stub.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

WebPlatform? instance;

class WebPlatform extends Platform {
  @override
  bool get isCanvasKit => context['flutterCanvasKit'] != null;
}

WebPlatform initPlatform() {
  if (instance == null) {
    setUrlStrategy(PathUrlStrategy()); // remove # in the URL
    instance = WebPlatform();
  }
  return instance!;
}
