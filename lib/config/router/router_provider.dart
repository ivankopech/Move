import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:move/config/observers/logging_route_observer.dart';
import 'package:move/features/map/presentation/screens/screens.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: MapInputScreen.path,
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
        path: PhoneNumberScreen.path,
        name: PhoneNumberScreen.name,
        builder: (context, state) => const PhoneNumberScreen(),
      ),
    ],
  );
});
