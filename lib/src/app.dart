import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod_architecture/src/routing/app_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/themes/theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      builder: (_, child) {
        // return AppStartupWidget(
        //   onLoaded: (_) => child!,
        // );
        return SafeArea(child: child!);
      },
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      title: 'MVVM Riverpod Architecture',
    );
  }
}
