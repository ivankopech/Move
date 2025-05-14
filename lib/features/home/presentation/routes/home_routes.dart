import 'package:go_router/go_router.dart';
import '../../presentation/screens/home_screen.dart';

class HomeRoutes {
  static List<GoRoute> get() {
    return [
      GoRoute(
        path: HomeScreen.path,
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
      ),
    ];
  }
}
