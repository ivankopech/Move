import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:move/config/observers/logging_route_observer.dart';
import 'package:move/features/auth/presentation/routes/auth_routes.dart';
import 'package:move/features/auth/presentation/screens/login_screen.dart';
import 'package:move/features/map/presentation/screens/screens.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: LoginScreen.path,
    observers: [LoggingRouteObserver()],
    routes: [
      GoRoute(
        path: AddressInputScreen.path,
        name: AddressInputScreen.name,
        builder: (context, state) => const AddressInputScreen(),
      ),
      GoRoute(
        path: MapInputScreen.path,
        name: MapInputScreen.name,
        builder: (context, state) => const MapInputScreen(),
      ),
     ...AuthRoutes.get(),
    ],
  );
});
