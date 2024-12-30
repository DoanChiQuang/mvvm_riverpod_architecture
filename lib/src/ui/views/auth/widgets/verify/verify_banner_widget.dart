import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod_architecture/src/constants/assets.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/user/user_model.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/view_model/auth_viewmodel.dart';

class VerifyBannerWidget extends ConsumerStatefulWidget {
  const VerifyBannerWidget({super.key});

  @override
  ConsumerState<VerifyBannerWidget> createState() => _VerifyBannerWidgetState();
}

class _VerifyBannerWidgetState extends ConsumerState<VerifyBannerWidget> {
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
    return Expanded(
      child: Column(
        children: [
          const Image(
            image: AssetImage(Assets.logo),
            width: 80,
          ),
          gapH16,
          Text(
            'Verify your email',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          gapH16,
          const Image(image: AssetImage(Assets.notifyMail)),
          gapH16,
          Text(
            'An email has been sent to ${_currentUser?.email} with link to verify your account. If you have not received the email after a few minutes, please check your spam folder.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
