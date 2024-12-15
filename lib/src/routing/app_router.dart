import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_riverpod_architecture/src/data/repositories/auth/auth_repository.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/verify/widgets/verify_screen.dart';
import 'package:mvvm_riverpod_architecture/src/utils/helpers/refresh_listenable.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/signin/widgets/signin_screen.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/signup/widgets/signup_screen.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/onboarding/widgets/onboarding_screen.dart';
import 'package:mvvm_riverpod_architecture/src/utils/helpers/scaffold_with_navigation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _todoNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'todo');
final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

enum AppRoute {
  onboarding,
  signIn,
  signUp,
  verify,
  todos,
  todo,
  addTodo,
  editTodo,
  account,
}

@riverpod
GoRouter goRouter(Ref ref) {
  final auth = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/onboarding',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final path = state.uri.path;
      final bool isLoggedIn = auth.currentUser != null;
      final bool isVerified = auth.currentUser?.emailVerified ?? false;
      if (isLoggedIn && isVerified) {
        if (path.startsWith('/onboarding') ||
            path.startsWith('/signIn') ||
            path.startsWith('/signUp')) {
          return '/todos';
        }
      }
      if (!isLoggedIn) {
        if (path.startsWith('/todos') || path.startsWith('/account')) {
          return '/onboarding';
        }
      }
      if (isLoggedIn && !isVerified) {
        if (path.startsWith('/onboarding') ||
            path.startsWith('/signIn') ||
            path.startsWith('/signUp')) {
          return '/verify';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges()),
    routes: [
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
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
      GoRoute(
        path: '/verify',
        name: AppRoute.verify.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: VerifyScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => NoTransitionPage(
          child: ScaffoldWithNavigationBar(navigationShell: navigationShell),
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
          StatefulShellBranch(
            navigatorKey: _accountNavigatorKey,
            routes: [
              GoRoute(
                path: '/account',
                name: AppRoute.account.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: Placeholder(),
                ),
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
