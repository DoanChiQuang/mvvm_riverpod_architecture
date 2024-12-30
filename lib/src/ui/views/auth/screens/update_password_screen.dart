import 'package:flutter/material.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/widgets/updatePassword/update_password_form_widget.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/widgets/updatePassword/update_password_note_widget.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_center.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Reset password')),
      body: const SingleChildScrollView(
        child: CustomCenter(
          padding: EdgeInsets.all(Sizes.s16),
          child: Column(
            children: [
              UpdatePasswordNoteWidget(),
              gapH16,
              UpdatePasswordFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
