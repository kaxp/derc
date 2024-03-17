import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class RequestInterceptor extends QueuedInterceptor {
  RequestInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    final isNetworkAvailable = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;

    if (!isNetworkAvailable) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
        ),
      );
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // When client_id of seatgeek is invalid
    if (err.response?.statusCode == HttpStatus.forbidden) {
      // We can decide/handle the UI/UX flow here, when client_id is invalid.
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          type: DioExceptionType.badCertificate,
        ),
      );
    }

    return handler.next(err);
  }
}
