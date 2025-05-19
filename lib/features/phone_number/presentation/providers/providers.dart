import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/api_client_provider.dart';
import '../../data/models/validate_phone_number_model.dart';
import '../../domain/repositories/validate_phone_number_repository_interface.dart';
import '../../domain/use_cases/validate_phone_number_use_case.dart';
import '../../data/repositories/validate_phone_number_repository_interface_implementation.dart';

final validatePhoneNumberRepositoryInterfaceProvider =
    Provider<ValidatePhoneNumberRepositoryInterface>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return ValidatePhoneNumberRepositoryInterfaceImplementation(apiClient);
    });

final validatePhoneNumberUseCaseProvider = Provider<ValidatePhoneNumberUseCase>(
  (ref) => ValidatePhoneNumberUseCase(
    validatePhoneNumberRepositoryInterface: ref.watch(
      validatePhoneNumberRepositoryInterfaceProvider,
    ),
  ),
);

final validatePhoneNumberProvider = StateProvider<ValidatePhoneNumberModel?>(
  (ref) => null,
);
