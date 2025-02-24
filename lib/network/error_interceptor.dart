import 'dart:async';
import 'package:common/logging.dart';
import 'package:common/network/api_exception.dart';
import 'package:http_interceptor/http_interceptor.dart';

class ErrorInterceptor implements InterceptorContract {
  static final logger = createLogger(ErrorInterceptor);

  @override
  FutureOr<bool> shouldInterceptRequest() => true;

  @override
  FutureOr<bool> shouldInterceptResponse() => true;

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) {
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    if (response.statusCode < 200 || response.statusCode > 299) {
      logger.e('ApiException $response');
      throw ApiException(
        response.statusCode,
        response.reasonPhrase ?? 'An unknown Error occurred',
      );
    }
    return response;
  }
}
