import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/login_state_notifier_provider.dart';
import '../providers/user_state_notifier_provider.dart';
import '../widgets/home_content.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  static const name = 'home';
  static const path = '/home';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return HomeContent();
    // return Scaffold(
    //   appBar: AppBar(
    //     leading: Builder(
    //       builder:
    //           (context) => IconButton(
    //             icon: const Icon(Icons.menu, color: Colors.white),
    //             onPressed: () => Scaffold.of(context).openDrawer(),
    //           ),
    //     ),
    //     backgroundColor: appColors.primaryColor,
    //   ),
    //   drawer: AppDrawer(),
    //   body: Column(
    //     children: [
    //       Container(
    //         margin: const EdgeInsets.only(top: 250),
    //         child: Text(
    //           'Welcome back!',
    //           style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
    //         ),
    //       ),
    //       Expanded(
    //         child: Align(
    //           alignment: Alignment.bottomCenter,
    //           child: Image.asset('assets/images/loginjeet.png'),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
