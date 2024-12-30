import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/user/user_model.dart';
import 'package:mvvm_riverpod_architecture/src/routing/app_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/view_model/auth_viewmodel.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_center.dart';
import 'package:mvvm_riverpod_architecture/src/utils/helpers/async_value_ui.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key});

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  late AuthViewModel _authViewModel;
  late UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _authViewModel = ref.read(authViewModelProvider.notifier);
    _currentUser = _authViewModel.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authViewModelProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: CustomCenter(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                CircleAvatar(
                  child: Text(
                    _currentUser?.email?.substring(0, 2).toUpperCase() ?? '',
                  ),
                ),
                gapH8,
                Text(
                  _currentUser?.email ?? '',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            gapH16,
            Card.filled(
              child: InkWell(
                onTap: () => context.goNamed(AppRoute.updatePass.name),
                child: const Padding(
                  padding: EdgeInsets.all(Sizes.s16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_reset_rounded,
                        size: Sizes.iconMd,
                      ),
                      gapW16,
                      Expanded(child: Text('Reset password')),
                      gapW16,
                      Icon(
                        Icons.keyboard_arrow_right_outlined,
                        size: Sizes.iconMd,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            gapH16,
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                minimumSize: const Size.fromHeight(Sizes.s56),
              ),
              onPressed: () => _authViewModel.signOut(),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
