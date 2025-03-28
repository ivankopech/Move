import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:move/config/secure_storage.dart';
import 'api_exception.dart';

typedef Result<T> = Either<ApiException, T>;

class ApiClient {
  final Dio _dio;
  final SecureStorageManager _secureStorage;

  ApiClient({Dio? dio, SecureStorageManager? secureStorage})
    : _dio = dio ?? Dio(),
      _secureStorage = secureStorage ?? SecureStorageManager() {
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    _dio
      ..options = BaseOptions(
        baseUrl: dotenv.env['BASEURL'] ?? '',
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {'Content-Type': 'application/json'},
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final token = await _secureStorage.readToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
          onError: (DioException error, handler) {
            if (error.response?.statusCode == 401) {
              // Manejo de token no válido
              _secureStorage.deleteToken();
            }
            return handler.next(error);
          },
        ),
      );
  }

  Future<Result<T?>> getData<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await _dio.get(endpoint);

      // Log basic response information
      developer.log(
        'GET Request to $endpoint',
        name: 'API_CLIENT',
        level: 800, // Info level
        time: DateTime.now(),
      );

      // Log detailed response information (conditional)
      if (response.statusCode! >= 400) {
        developer.log(
          'Response [${response.statusCode}] from $endpoint',
          name: 'API_CLIENT',
          level: 900, // Warning level
          time: DateTime.now(),
        );
        developer.log(
          'Response data: ${response.data}',
          name: 'API_CLIENT',
          level: 900, // Warning level
        );
      } else {
        developer.log(
          'Response [${response.statusCode}] from $endpoint',
          name: 'API_CLIENT',
          level: 800, // Info level (for successful responses)
          time: DateTime.now(),
        );
      }

      if (response.data != null) {
        return Right(fromJson(response.data));
      } else {
        developer.log(
          'Error: Null response data from $endpoint',
          name: 'API_CLIENT',
          level: 900, // Warning level
        );
        return const Left(ApiException.nullValueResponse);
      }
    } on DioException catch (e) {
      developer.log(
        'Error in GET Request to $endpoint',
        name: 'API_CLIENT',
        level: 1000, // Error level
        error: e.message,
        stackTrace: e.stackTrace,
      );

      return Left(
        ApiException(
          message: 'Error en GET: ${e.message}',
          code: e.response?.statusCode?.toString(),
          data: e.response?.data,
        ),
      );
    }
  }

  Future<Result<T?>> postData<T>(
    String endpoint,
    Map<String, dynamic> data,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    // Log de solicitud
    developer.log(
      'POST Request to $endpoint',
      name: 'API_CLIENT',
      level: 800, // Info level
      time: DateTime.now(),
    );
    developer.log(
      'Payload: ${data.toString()}',
      name: 'API_CLIENT',
      level: 800,
    );

    try {
      final response = await _dio.post(endpoint, data: data);

      // Log de respuesta exitosa
      developer.log(
        'Response [${response.statusCode}] from $endpoint',
        name: 'API_CLIENT',
        level: 800, // Info level
        time: DateTime.now(),
      );
      developer.log(
        'Response data: ${response.data}',
        name: 'API_CLIENT',
        level: 800,
      );

      if (response.data != null) {
        return Right(fromJson(response.data));
      } else {
        // Log de respuesta nula
        developer.log(
          'Error: Null response data from $endpoint',
          name: 'API_CLIENT',
          level: 900, // Warning level
        );
        return const Left(ApiException.nullValueResponse);
      }
    } on DioException catch (e) {
      // Log de error
      developer.log(
        'Error in POST Request to $endpoint',
        name: 'API_CLIENT',
        level: 1000, // Error level
        error: e.message,
        stackTrace: e.stackTrace,
      );

      return Left(
        ApiException(
          message: 'Error en POST: ${e.message}',
          code: e.response?.statusCode?.toString(),
          data: e.response?.data,
        ),
      );
    }
  }

  Future<Result<List<T>>> getListData<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await _dio.get(endpoint);

      // Log básico
      developer.log(
        'GET Request to $endpoint',
        name: 'API_CLIENT',
        level: 800,
        time: DateTime.now(),
      );

      // Validar el código de respuesta y loggear errores si es necesario
      if (response.statusCode! >= 400) {
        developer.log(
          'Response [${response.statusCode}] from $endpoint',
          name: 'API_CLIENT',
          level: 900,
        );
        developer.log(
          'Response data: ${response.data}',
          name: 'API_CLIENT',
          level: 900,
        );
        return const Left(ApiException.nullValueResponse);
      }

      // Verificar si el cuerpo de la respuesta es una lista
      if (response.data is List) {
        final List<dynamic> dataList = response.data as List<dynamic>;

        // Mapear cada elemento al modelo esperado
        final List<T> convertedList =
            dataList
                .map((item) => fromJson(item as Map<String, dynamic>))
                .toList();

        return Right(convertedList);
      } else {
        developer.log(
          'Error: Response is not a List<dynamic>',
          name: 'API_CLIENT',
          level: 900,
        );
        return const Left(ApiException.nullValueResponse);
      }
    } on DioException catch (e) {
      // Manejo de errores específicos de Dio
      developer.log(
        'Error in GET Request to $endpoint',
        name: 'API_CLIENT',
        level: 1000,
        error: e.message,
        stackTrace: e.stackTrace,
      );

      return Left(
        ApiException(
          message: 'Error en GET: ${e.message}',
          code: e.response?.statusCode?.toString(),
          data: e.response?.data,
        ),
      );
    } catch (e, stackTrace) {
      // Manejo de errores inesperados
      developer.log(
        'Unexpected error in GET Request to $endpoint: $e',
        name: 'API_CLIENT',
        level: 1000,
        stackTrace: stackTrace,
      );

      return Left(
        ApiException(message: 'Error inesperado: $e', stackTrace: stackTrace),
      );
    }
  }

  Future<Result<T?>> putData<T>(
    String endpoint,
    Map<String, dynamic> data,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    developer.log(
      'PUT Request to $endpoint',
      name: 'API_CLIENT',
      level: 800,
      time: DateTime.now(),
    );
    developer.log(
      'Payload: ${data.toString()}',
      name: 'API_CLIENT',
      level: 800,
    );

    try {
      final response = await _dio.put(endpoint, data: data);

      developer.log(
        'Response [${response.statusCode}] from $endpoint',
        name: 'API_CLIENT',
        level: 800,
        time: DateTime.now(),
      );
      developer.log(
        'Response data: ${response.data}',
        name: 'API_CLIENT',
        level: 800,
      );

      // Si la respuesta es null o vacía, devuelve Right(null)
      if (response.data == null ||
          (response.data is Map && response.data.isEmpty)) {
        return const Right(
          null,
        ); // Permite un resultado vacío sin romper el flujo
      }

      return Right(fromJson(response.data));
    } on DioException catch (e) {
      developer.log(
        'Error in PUT Request to $endpoint',
        name: 'API_CLIENT',
        level: 1000,
        error: e.message,
        stackTrace: e.stackTrace,
      );

      return Left(
        ApiException(
          message: 'Error en PUT: ${e.message}',
          code: e.response?.statusCode?.toString(),
          data: e.response?.data,
        ),
      );
    }
  }
}
