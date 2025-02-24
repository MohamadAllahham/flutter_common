export 'platform_stub.dart'
    if (dart.library.html) 'package:common/platform/web_platform.dart'
    if (dart.library.io) 'package:common/platform/io_platform.dart';
