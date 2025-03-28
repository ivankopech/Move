import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/config/api_client_provider.dart';
import 'package:move/features/map/data/repositories/repositories.dart';
import 'package:move/features/map/domain/repositories/repositories.dart';
import 'package:move/features/map/domain/use_cases/use_cases.dart';

// REPOSITORY PROVIDERS
final sampleRepositoryInterfaceProvider = Provider<SampleRepositoryInterface>((
  ref,
) {
  final apiClient = ref.read(apiClientProvider);
  return SampleRepositoryInterfaceImplementation(apiClient);
});
// USE CASE PROVIDERS
final sampleUseCaseProvider = Provider<SampleUseCase>(
  (ref) => SampleUseCase(
    sampleRepositoryInterface: ref.watch(sampleRepositoryInterfaceProvider),
  ),
);
