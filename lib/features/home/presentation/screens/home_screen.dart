import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/login_state_notifier_provider.dart';
import '../providers/user_state_notifier_provider.dart';
import '../widgets/home_content.dart';
import '../../../map/presentation/screens/map_input.dart';
import '../../../requests/presentation/screens/get_requests_screen.dart';
import '../../../../utils/utils.dart';

import '../widgets/app_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  static const name = 'home';
  static const path = '/home';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeContent(),
    MapInputScreen(),
    GetRequestsScreen(),
  ];

  final List<String> _titles = const ['Home', 'New Request', 'My Requests'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId =
          ref
              .read(loginStateNotifierProvider.notifier)
              .authResponseModel
              ?.result
              ?.userId;
      if (userId != null) {
        ref.read(userStateNotifierProvider.notifier).getUserData(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: appTextStyles.subhead.copyWith(color: Colors.white),
        ),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        backgroundColor: appColors.primaryColor,
      ),
      drawer: AppDrawer(
        onItemSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          Navigator.pop(context);
        },
      ),
      body: _screens[_selectedIndex],
    );
  }
}
