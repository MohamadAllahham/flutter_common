import 'dart:convert';

import 'package:flutter_common/logging.dart';

class ApiResponse {
  static final logger = createLogger(ApiResponse);

  final dynamic _body;

  const ApiResponse(this._body);

  factory ApiResponse.decode(String rawBody) {
    if (rawBody.isEmpty) {
      logger.w('Response is an empty string.');
    }
    final decodedBody = rawBody.isEmpty ? null : jsonDecode(rawBody);
    return ApiResponse(decodedBody);
  }

  bool get isEmpty => _body == null;
  bool get isNotEmpty => !isEmpty;

  Map<String, dynamic> asMap() {
    if (_body is Map<String, dynamic>) {
      return _body;
    }
    if (_body is Map && (_body).isEmpty) {
      return {};
    }
    logger
        .e('Response $_body of type ${_body.runtimeType} is not a valid map.');
    throw TypeError();
  }

  List<Map<String, dynamic>> asList() {
    if (_body is List<Map<String, dynamic>>) {
      return _body;
    }
    if (_body is List &&
        _body.every((e) => e is Map<String, dynamic>)) {
      return _body.map((e) => e as Map<String, dynamic>).toList();
    }
    logger.e(
      'Response $_body of tperm_service.dartype ${_body.runtimeType} is not a valid list.',
    );
    throw TypeError();
  }
}
