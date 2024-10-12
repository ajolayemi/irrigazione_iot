// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpHeaders {
  static const accept = 'accept';

  static const contentType = 'Content-type';

  static const json = 'application/json';

  static const authorization = 'Authorization';

  static const bearer = 'Bearer';

  static const jsonContentType = {contentType: json};
}

// TODO: properly handle exceptions
/// Wraps the http client to make http requests
class HttpRepository {
  HttpRepository({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 5),
    this.receiveTimeout = const Duration(seconds: 3),
  }) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('Request: ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('Response: ${response.data}');
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          debugPrint('Error: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  /// base url
  final String baseUrl;

  /// Optional connection timeout
  ///
  /// Defaults to 5 seconds
  final Duration? connectTimeout;

  /// Optional receive timeout
  ///
  /// Defaults to 3 seconds
  final Duration? receiveTimeout;

  // Dio client
  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    ),
  );

  /// Performs a GET request
  /// [path] is the endpoint for the request
  /// [headers] are the headers for the request
  /// Returns the response data
  Future<Response> get({
    required String path,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final res = await _dio.get(
        path,
        options: Options(headers: headers),
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  /// Performs a POST request
  /// [path] is the endpoint for the request
  /// [data] is the payload for the request
  /// [headers] are the headers for the request
  /// Returns the response data
  Future<Response> post({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final res = await _dio.post(
        path,
        data: data,
        options: Options(headers: headers),
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
