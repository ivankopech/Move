import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/api_client_provider.dart';
import '../../data/repositories/get_request_repository_interface_implementation.dart';
import '../../domain/repositories/get_requests_repository_interface.dart';
import '../../domain/use_cases/get_requests_data_use_case.dart';

final getRequestsRepositoryInterfaceProvider =
    Provider<GetRequestsRepositoryInterface>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return GetRequestRepositoryInterfaceImplementation(apiClient);
    });

//USE CASE PROVIDER
final getRequestsDataUseCaseProvider = Provider<GetRequestsDataUseCase>(
  (ref) => GetRequestsDataUseCase(
    getRequestsRepositoryInterface: ref.watch(
      getRequestsRepositoryInterfaceProvider,
    ),
  ),
);
