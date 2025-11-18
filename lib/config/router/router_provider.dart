import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:move/config/observers/logging_route_observer.dart';
import 'package:move/features/home/presentation/screens/track_delivery_screen.dart';
import 'package:move/features/requests/data/models/get_requests_model.dart';
import 'package:move/features/requests/presentation/screens/get_requests_screen.dart';
import '../../features/auth/presentation/routes/auth_routes.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/routes/home_routes.dart';

import '/features/map/presentation/screens/screens.dart';

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
      GoRoute(
        path: ArrivalTimeScreen.path,
        name: ArrivalTimeScreen.name,
        builder: (context, state) => const ArrivalTimeScreen(),
      ),
      GoRoute(
        path: ItemInformationScreen.path,
        name: ItemInformationScreen.name,
        builder: (context, state) => const ItemInformationScreen(),
      ),
      GoRoute(
        path: PaymentScreen.path,
        name: PaymentScreen.name,
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: GetRequestsScreen.path,
        name: GetRequestsScreen.name,
        builder: (context, state) {
          final initialIndex = state.extra as int? ?? 0;
          return GetRequestsScreen(initialIndex: initialIndex);
        },
      ),
      GoRoute(
        path: TrackDeliveryScreen.path,
        name: TrackDeliveryScreen.name,
        builder: (context, state) {
          final request = state.extra as GetRequestsModel;
          return TrackDeliveryScreen(requestsModel: request);
        },
      ),
      ...AuthRoutes.get(),
      ...HomeRoutes.get(),
    ],
  );
});
