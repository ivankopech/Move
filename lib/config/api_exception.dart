import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  const ApiException({
    required this.message,
    this.code,
    this.stackTrace,
    this.data,
  });

  final String message;
  final String? code;
  final StackTrace? stackTrace;
  final Map<String, dynamic>? data;

  @override
  String toString() =>
      'ApiException(message: $message, code: $code, stackTrace: '
      '$stackTrace, data: $data),)';

  @override
  List<Object?> get props => [
        message,
        code,
        stackTrace,
        data,
      ];

  static const ApiException nullValueResponse =
      ApiException(message: 'Null value response on a non-nullable type');
}