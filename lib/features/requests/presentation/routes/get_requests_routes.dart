import 'package:go_router/go_router.dart';
import '../screens/get_requests_screen.dart';

class GetRequestsRoutes {
  static List<GoRoute> get() {
    return [
      GoRoute(
        path: GetRequestsScreen.path,
        name: GetRequestsScreen.name,
        builder: (context, state) => const GetRequestsScreen(),
      ),
    ];
  }
}
