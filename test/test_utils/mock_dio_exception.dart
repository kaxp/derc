import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

const String validJson = '''
          {
              "detail": "error",
              "message": "Not Found",
              "errorCode": 404
          }
      ''';

class MockDioException extends Mock implements DioException {
  MockDioException({
    String json = validJson,
    this.type = DioExceptionType.badResponse,
    this.error,
    this.message = '',
  }) : response = Response(
          requestOptions: RequestOptions(path: 'url'),
          data: jsonDecode(json),
        );

  final Response response;
  final DioExceptionType type;
  final dynamic error;
  final String message;

  MockDioException.withErrorData({
    String errorCode = '1000',
    String title = 'title',
    String detail = 'detail',
    this.message = '',
  })  : response = Response(
          requestOptions: RequestOptions(path: 'url'),
          data: {
            'errors': [
              {
                'errorCode': errorCode,
                'title': title,
                'detail': detail,
              }
            ]
          },
        ),
        type = DioExceptionType.badResponse,
        error = null;
}
