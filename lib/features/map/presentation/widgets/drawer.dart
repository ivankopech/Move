import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/map_input.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Menu de opciones'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Log In'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(MapInputScreen.name);
              context.pushReplacementNamed(MapInputScreen.name);
            },
          ),
          const Divider(),

          // Expanded(
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //   ),
          // ),
          // Align(
          //   alignment: FractionalOffset.bottomCenter,
          //   child: ListTile(
          //     leading: const Icon(Icons.login_outlined),
          //     title: const Text('Cerrar Sesion'),
          //     onTap: () async {

          //       //Navigator.of(context).pushNamed(LoginScreen.routeName);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
