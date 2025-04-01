import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/features/auth/data/models/auth_response_model.dart';
import 'package:move/features/auth/presentation/providers/providers.dart';
import 'package:move/features/auth/presentation/providers/state/login_state_notifier.dart';

final loginStateNotifierProvider =
    StateNotifierProvider<LoginStateNotifier, AsyncValue<AuthResponseModel?>>(
      (ref) {
        return LoginStateNotifier(
          loginUseCase: ref.read(loginUseCaseProvider),
        );
      },
    );