import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/config/router/router_provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
