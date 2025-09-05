import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/api_client_provider.dart';
import '../domain/repositories/send_code_repository_interface.dart';
import '../domain/use_cases/send_code_use_case.dart';
import '../data/repositories/send_code_repository_interface_implementation.dart';

//SEND CODE

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://move.softdev.ar/core/api/TokenAuth/SendOtp',
      headers: {'Content-Type': 'application/json'},
    ),
  );
});

final sendCodeRepositoryInterfaceProvider =
    Provider<SendCodeRepositoryInterface>((ref) {
      final dio = ref.read(dioProvider);
      return SendCodeRepositoryInterfaceImplementation(dio);
    });

final sendCodeUseCaseProvider = Provider<SendCodeUseCase>(
  (ref) => SendCodeUseCase(
    sendCodeRepositoryInterface: ref.watch(sendCodeRepositoryInterfaceProvider),
  ),
);
