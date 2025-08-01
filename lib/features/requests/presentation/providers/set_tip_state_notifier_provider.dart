import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/set_tip_model.dart';
import '../../presentation/providers/providers.dart';
import '../../presentation/providers/state/set_tip_state_notifier.dart';

final setTipStateNotifierProvider =
    StateNotifierProvider<SetTipStateNotifier, AsyncValue<SetTipModel?>>((ref) {
      return SetTipStateNotifier(
        setTipUseCase: ref.read(setTipUseCaseProvider),
      );
    });
