import 'dart:async';
import 'package:flutter_common/logging.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  static final logger = createLogger(LoggingInterceptor);

  @override
  FutureOr<bool> shouldInterceptRequest() => true;

  @override
  FutureOr<bool> shouldInterceptResponse() => true;

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) {
    logger.t('${request.method} ${request.url}');
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    return response;
  }
}
