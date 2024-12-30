import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/todo/todo_model.dart';
import 'package:mvvm_riverpod_architecture/src/routing/app_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/todo/view_model/todos_viewmodel.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_cupertino_action_sheet.dart';
import 'package:mvvm_riverpod_architecture/src/utils/helpers/async_value_ui.dart';

class TodoItemWidget extends ConsumerWidget {
  const TodoItemWidget({super.key, required this.todo});

  final TodoModel todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      todosViewModelProvider(const [
        TodosType.edit,
        TodosType.delete,
      ]),
      (_, state) {
        state.showAlertDialogOnError(context);
      },
    );
    final todosViewModel = ref.read(todosViewModelProvider(const [
      TodosType.edit,
      TodosType.delete,
    ]).notifier);
    return Card.outlined(
      child: InkWell(
        onTap: () => context.goNamed(
          AppRoute.editTodo.name,
          pathParameters: {'id': todo.id!},
          extra: todo,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.s16),
          child: Row(
            children: [
              IconButton(
                highlightColor: Colors.black.withOpacity(0),
                onPressed: () => todosViewModel.edit(
                  todoId: todo.id!,
                  title: todo.title,
                  description: todo.description,
                  status: !todo.status,
                ),
                icon: Icon(
                  todo.status ? Icons.check_circle : Icons.circle_outlined,
                  size: Sizes.iconMd,
                  color: todo.status ? Colors.green : null,
                ),
              ),
              gapW16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todo.title),
                    gapH4,
                    Text(todo.description),
                  ],
                ),
              ),
              gapW16,
              IconButton(
                highlightColor: Colors.black.withOpacity(0),
                icon: const Icon(
                  Icons.more_horiz,
                  size: Sizes.iconMd,
                ),
                onPressed: () => showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomCupertinoActionSheet(
                      defaultText: 'Edit',
                      onDefaultPressed: () => context.goNamed(
                        AppRoute.editTodo.name,
                        pathParameters: {'id': todo.id!},
                        extra: todo,
                      ),
                      destructiveText: 'Delete',
                      onDestructivePressed: () => todosViewModel.delete(
                        todoId: todo.id!,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
