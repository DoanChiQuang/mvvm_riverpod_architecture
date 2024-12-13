import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/signin/widgets/signin_screen.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/signup/widgets/signup_screen.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/onboarding/widgets/onboarding_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _todoNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'todo');

enum AppRoute {
  onboaring,
  signIn,
  signUp,
  todos,
  todo,
  addTodo,
  editTodo,
}

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/onboarding',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // return '/onboarding';
      return null;
    },
    // refreshListenable: GoRouterRefreshStream()
    routes: [
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboaring.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SigninScreen(),
        ),
      ),
      GoRoute(
        path: '/signUp',
        name: AppRoute.signUp.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SignupScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) =>
            const NoTransitionPage(
          child: Placeholder(),
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _todoNavigatorKey,
            routes: [
              GoRoute(
                path: '/todos',
                name: AppRoute.todos.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: Placeholder(),
                ),
                routes: [
                  GoRoute(
                    path: 'add',
                    name: AppRoute.addTodo.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      return const MaterialPage(
                        fullscreenDialog: true,
                        child: Placeholder(),
                      );
                    },
                  ),
                  GoRoute(
                    path: ':id',
                    name: AppRoute.todo.name,
                    pageBuilder: (context, state) {
                      // final id = state.pathParameters['id']!;
                      return const MaterialPage(
                        child: Placeholder(),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'edit',
                        name: AppRoute.editTodo.name,
                        pageBuilder: (context, state) {
                          // final todoId = state.pathParameters['id'];
                          // final todo = state.extra as Todo;
                          return const MaterialPage(
                            fullscreenDialog: true,
                            child: Placeholder(),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: Placeholder(),
    ),
  );
}
