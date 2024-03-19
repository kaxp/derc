import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// [AppDio] class is used for defining the various dio
/// client types we can have in our app. For e.g.
/// [noAuthDio] when we need to call APIs that does not require user
/// authentication or can create [authDio] when authentication is
/// required.
class AppDio extends Equatable {
  const AppDio({
    required this.noAuthDio,
  });

  final Dio noAuthDio;

  @override
  List<Object?> get props => [noAuthDio];
}
