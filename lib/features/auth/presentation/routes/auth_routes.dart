import 'package:go_router/go_router.dart';
import 'package:move/features/auth/presentation/screens/screens.dart';

class AuthRoutes {
  static const String registerPath = '/register';
  static const String registerName = 'register';

  static List<GoRoute> get() {
    return [
      GoRoute(
        path: LoginScreen.path,
        name: LoginScreen.name,
        builder: (context, state) => const LoginScreen(),
      ),
    ];
  }
}
