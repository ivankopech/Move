import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../map/presentation/screens/map_input.dart';
import '../../../requests/presentation/screens/get_requests_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Options'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.pushReplacementNamed(HomeScreen.name);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.file_present),
            title: const Text('New Request'),
            onTap: () {
              context.go(MapInputScreen.path);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.question_mark_outlined),
            title: const Text('My Requests'),
            onTap: () {
              context.go(GetRequestsScreen.path);
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              context.go(LoginScreen.path);
            },
          ),
        ],
      ),
    );
  }
}
