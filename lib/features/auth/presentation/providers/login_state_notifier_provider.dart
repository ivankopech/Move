import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/auth_response_model.dart';
import '../providers/providers.dart';
import '../providers/state/login_state_notifier.dart';

final loginStateNotifierProvider =
    StateNotifierProvider<LoginStateNotifier, AsyncValue<AuthResponseModel?>>((
      ref,
    ) {
      return LoginStateNotifier(loginUseCase: ref.read(loginUseCaseProvider));
    });
