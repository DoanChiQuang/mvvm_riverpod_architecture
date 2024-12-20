import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/view_model/auth_viewmodel.dart';
import 'package:mvvm_riverpod_architecture/src/utils/helpers/async_value_ui.dart';

class SigninFormWidget extends ConsumerStatefulWidget {
  const SigninFormWidget({super.key});

  @override
  ConsumerState<SigninFormWidget> createState() => _SigninFormWidgetState();
}

class _SigninFormWidgetState extends ConsumerState<SigninFormWidget> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _isObscurePasswordText = true;

  void _setObscurePasswordText() {
    setState(() => _isObscurePasswordText = !_isObscurePasswordText);
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState?.value;
      final viewModel = ref.read(authViewModelProvider.notifier);
      await viewModel.signIn(
        email: formData?['email'],
        password: formData?['password'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authViewModelProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final viewModel = ref.watch(authViewModelProvider);
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'email',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: Theme.of(context).inputDecorationTheme.border,
              labelText: 'Email',
              prefixIcon: const Icon(
                Icons.email_outlined,
                size: Sizes.iconMd,
              ),
            ),
            keyboardType: TextInputType.text,
            validator: FormBuilderValidators.email(),
          ),
          gapH16,
          FormBuilderTextField(
            name: 'password',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: Theme.of(context).inputDecorationTheme.border,
              labelText: 'Password',
              prefixIcon: const Icon(
                Icons.lock_outline,
                size: Sizes.iconMd,
              ),
              suffixIcon: IconButton(
                onPressed: _setObscurePasswordText,
                icon: Icon(
                  _isObscurePasswordText
                      ? AntDesign.eye_invisible_outline
                      : AntDesign.eye_outline,
                  size: Sizes.iconMd,
                ),
              ),
            ),
            obscureText: _isObscurePasswordText,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.text,
            validator: FormBuilderValidators.minLength(8),
          ),
          gapH16,
          FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(Sizes.s56),
            ),
            onPressed: !viewModel.isLoading ? _onSubmit : null,
            child: !viewModel.isLoading
                ? const Text('Continue')
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      gapW16,
                      Text('Loading...'),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
