import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/screens/login_screen.dart';

class AppDrawer extends StatelessWidget {
  final void Function(int) onItemSelected;

  const AppDrawer({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Menú de opciones'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => onItemSelected(0),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.file_present),
            title: const Text('New Request'),
            onTap: () => onItemSelected(1),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.file_present),
            title: const Text('My Requests'),
            onTap: () => onItemSelected(2),
          ),
          // ListTile(
          //   leading: const Icon(Icons.add_circle_outline_rounded),
          //   title: const Text('Propuestos'),
          //   onTap: () => onItemSelected(2),
          // ),
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
