import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/widgets/loader_widget.dart';
import '../providers/user_state_notifier_provider.dart';
import '../../../../utils/utils.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateNotifierProvider);

    return userState.when(
      data: (data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Move', style: TextStyle(color: Colors.grey)),
                    Text(
                      'Welcome ${ref.read(userStateNotifierProvider.notifier).userResponseModel?.fullName ?? ''}',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: appImage(AppAssets.loginJeet),
              ),
            ),
          ],
        );
      },
      error:
          (error, stackTrace) =>
              const Center(child: Text('Error cargando usuario')),
      loading: () => const LoaderWidget(),
    );
  }
}
