import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kapil_sahu_cred/constants/app_strings.dart';
import 'package:kapil_sahu_cred/utils/dio_error_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import '../test_utils/mock_dio_exception.dart';

void main() async {
  group('test errorMessage() extension method for DioException', () {
    test(
        'will return network error message for DioExceptionType.connectTimeout',
        () {
      final dioException =
          MockDioException(type: DioExceptionType.connectionTimeout);
      expect(dioException.errorMessage(), AppStrings.networkErrorMessage);
    });

    test('will return network error message for DioExceptionType.sendTimeout',
        () {
      final dioException = MockDioException(type: DioExceptionType.sendTimeout);
      expect(dioException.errorMessage(), AppStrings.networkErrorMessage);
    });

    test(
        'will return network error message for DioExceptionType.receiveTimeout',
        () {
      final dioException =
          MockDioException(type: DioExceptionType.receiveTimeout);
      expect(dioException.errorMessage(), AppStrings.networkErrorMessage);
    });

    test(
        'will return request canceled error message for DioExceptionType.cancel',
        () {
      final dioException = MockDioException(type: DioExceptionType.cancel);
      expect(dioException.errorMessage(), AppStrings.networkRequestCanceled);
    });

    test(
        'will return network error message for DioExceptionType.badResponse and error is SocketException',
        () async {
      final dioException = MockDioException(
          type: DioExceptionType.badResponse,
          error: const SocketException('no internet'));
      expect(dioException.errorMessage(), AppStrings.networkErrorMessage);
    });

    test(
        'will return something went wrong error message for DioExceptionType.badResponse',
        () async {
      final dioException = MockDioException(type: DioExceptionType.badResponse);
      expect(dioException.errorMessage(), AppStrings.unknownError);
    });

    test(
        'will return invalid clientId error message for DioExceptionType.badCertificate',
        () async {
      final dioException =
          MockDioException(type: DioExceptionType.badCertificate);
      expect(dioException.errorMessage(), AppStrings.invalidClientIdError);
    });
  });
}
