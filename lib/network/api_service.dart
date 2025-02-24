import 'dart:convert';
import 'dart:io';

import 'package:common/logging.dart';
import 'package:common/network/api_exception.dart';
import 'package:common/network/api_response.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';

class ApiService {
  static final logger = createLogger(ApiService);

  late final String _scheme, _host;
  late final int? _port;
  late final InterceptedHttp _http;
  InterceptedHttp get http => _http;

  ApiService({
    required String apiUrl,
    List<InterceptorContract> initialInterceptors = const [],
  }) {
    final regex = RegExp(r'^(.*)://(.*?)(?::(\d+))?$');
    final match = regex.matchAsPrefix(apiUrl)!;
    _scheme = match.group(1)!;
    _host = match.group(2)!;
    _port = match.group(3) == null ? null : int.tryParse(match.group(3)!);
    logger.t('scheme: $_scheme, host: $_host, port: $_port');

    _http = InterceptedHttp.build(interceptors: initialInterceptors);
  }

  void addInterceptor(InterceptorContract interceptor) {
    _http.interceptors.add(interceptor);
  }

  Uri url(String endpoint, {Map<String, String?>? queryParams}) {
    return Uri(
      scheme: _scheme,
      host: _host,
      port: _port,
      path: endpoint,
      queryParameters: queryParams,
    );
  }

  Future<ApiResponse> get(
    String endpoint, {
    Map<String, String?>? queryParams,
  }) async {
    try {
      final res = await _http.get(url(endpoint, queryParams: queryParams));
      return ApiResponse.decode(res.body);
    } on HttpException catch (e) {
      logger.e('An error occured: $e');
      // TODO: redirect to an offline-page
      throw ApiException(-1, 'No connection to server');
    }
  }

  Future<ApiResponse> put(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String?>? queryParams,
  }) async {
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    try {
      final res = await _http.put(
        url(endpoint, queryParams: queryParams),
        headers: headers,
        body: jsonEncode(body),
      );
      return ApiResponse.decode(res.body);
    } on HttpException catch (e) {
      logger.e('An error occured: $e');
      // TODO: redirect to an offline-page
      throw ApiException(-1, 'No connection to server');
    }
  }

  Future<ApiResponse> post(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String?>? queryParams,
  }) async {
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    try {
      final res = await _http.post(
        url(endpoint, queryParams: queryParams),
        headers: headers,
        body: jsonEncode(body),
      );
      return ApiResponse.decode(res.body);
    } on HttpException catch (e) {
      logger.e('An error occured: $e');
      // TODO: redirect to an offline-page
      throw ApiException(-1, 'No connection to server');
    }
  }

  Future<ApiResponse> delete(
    String endpoint, {
    Map<String, String?>? queryParams,
  }) async {
    try {
      final res = await _http.delete(url(endpoint, queryParams: queryParams));
      return ApiResponse.decode(res.body);
    } on HttpException catch (e) {
      logger.e('An error occured: $e');
      // TODO: redirect to an offline-page
      throw ApiException(-1, 'No connection to server');
    }
  }
}
