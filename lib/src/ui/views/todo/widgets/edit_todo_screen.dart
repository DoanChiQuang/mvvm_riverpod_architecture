import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/todo/todo_model.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/todo/view_model/todo_viewmodel.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_center.dart';
import 'package:mvvm_riverpod_architecture/src/utils/helpers/async_value_ui.dart';

class EditTodoScreen extends ConsumerStatefulWidget {
  const EditTodoScreen({
    super.key,
    this.todoId,
    this.todo,
  });

  final String? todoId;
  final TodoModel? todo;

  @override
  ConsumerState<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends ConsumerState<EditTodoScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  late String? _title;
  late String? _description;

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState?.value;
      final title = formData?['title'];
      final description = formData?['description'];
      if (title != _title && description != _description) {
        final todoViewModel =
            ref.read(todoViewModelProvider(TodoActivity.edit.name).notifier);
        final success = await todoViewModel.submit(
          todoId: widget.todoId,
          title: title,
          description: description,
        );
        if (success && mounted) {
          context.pop();
        }
      } else {
        context.pop();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _title = widget.todo?.title;
      _description = widget.todo?.description;
    } else {
      _title = '';
      _description = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      todoViewModelProvider(TodoActivity.edit.name),
      (_, state) => state.showAlertDialogOnError(context),
    );
    final todoStateViewModel =
        ref.watch(todoViewModelProvider(TodoActivity.edit.name));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todoId == null ? 'Create' : 'Edit'),
      ),
      body: CustomCenter(
        padding: const EdgeInsets.all(Sizes.s16),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'title',
                      initialValue: _title,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: Theme.of(context).inputDecorationTheme.border,
                        labelText: 'Title',
                      ),
                      keyboardType: TextInputType.text,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.maxLength(50),
                      ]),
                    ),
                    gapH16,
                    FormBuilderTextField(
                      minLines: 1,
                      maxLines: 3,
                      name: 'description',
                      initialValue: _description,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: Theme.of(context).inputDecorationTheme.border,
                        labelText: 'Description',
                      ),
                      keyboardType: TextInputType.text,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.maxLength(255),
                      ]),
                    ),
                  ],
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(Sizes.s56),
                ),
                onPressed: !todoStateViewModel.isLoading ? _onSubmit : null,
                child: !todoStateViewModel.isLoading
                    ? const Text('Save')
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          gapW16,
                          Text('Saving...'),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
