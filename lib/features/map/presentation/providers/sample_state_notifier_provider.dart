import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/features/map/data/models/models.dart';
import 'package:move/features/map/presentation/providers/state/states.dart';
import 'package:move/features/map/presentation/providers/providers.dart';

final sampleStateNotifierProvider = StateNotifierProvider<SampleStateNotifier,
    AsyncValue<SampleResponseModel?>>(
  (ref) {
    return SampleStateNotifier(
      sampleUseCase: ref.read(sampleUseCaseProvider),
    );
  },
);
