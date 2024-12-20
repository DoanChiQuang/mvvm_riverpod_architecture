import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/view_model/auth_viewmodel.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/widgets/verify/verify_banner_widget.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_center.dart';
import 'package:mvvm_riverpod_architecture/src/utils/formats/format.dart';
import 'package:mvvm_riverpod_architecture/src/utils/helpers/async_value_ui.dart';

class VerifyScreen extends ConsumerStatefulWidget {
  const VerifyScreen({super.key});

  @override
  ConsumerState<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends ConsumerState<VerifyScreen> {
  final _countDownSecond = 120;
  late Timer _timer;
  late bool _canResend;
  late int _remainingSeconds;

  void _startCountDown() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (timer) {
        if (_remainingSeconds <= 0) {
          setState(() => _canResend = true);
          timer.cancel();
        } else {
          setState(() => _remainingSeconds--);
        }
      },
    );
  }

  void _resend() {
    setState(() {
      _canResend = false;
      _remainingSeconds = _countDownSecond;
    });
    ref.read(authViewModelProvider.notifier).sendMail();
    _startCountDown();
  }

  @override
  void initState() {
    super.initState();
    _canResend = false;
    _remainingSeconds = _countDownSecond;
    Future(() {
      ref.read(authViewModelProvider.notifier).sendMail();
      _startCountDown();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authViewModelProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    return Scaffold(
      body: CustomCenter(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          children: [
            const VerifyBannerWidget(),
            gapH16,
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(Sizes.s56),
              ),
              onPressed: _canResend ? _resend : null,
              child: Text(_canResend
                  ? 'Resend'
                  : Format.timer(_remainingSeconds, minute: true)),
            ),
            gapH16,
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(Sizes.s56),
              ),
              onPressed: () =>
                  ref.read(authViewModelProvider.notifier).signOut(),
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
