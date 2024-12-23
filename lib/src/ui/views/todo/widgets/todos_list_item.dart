import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/todo/todo_model.dart';
import 'package:mvvm_riverpod_architecture/src/routing/app_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/todo/view_model/todo_viewmodel.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/empty_data.dart';
import 'package:mvvm_riverpod_architecture/src/utils/helpers/async_value_ui.dart';

class TodosListItem extends StatelessWidget {
  const TodosListItem({super.key, required this.todos});

  final List<TodoModel> todos;

  @override
  Widget build(BuildContext context) {
    return todos.isNotEmpty
        ? ListView.separated(
            itemCount: todos.length,
            separatorBuilder: (context, index) => gapH16,
            itemBuilder: (context, index) => TodosItem(todo: todos[index]),
          )
        : const EmptyData();
  }
}

class TodosItem extends ConsumerStatefulWidget {
  const TodosItem({super.key, required this.todo});

  final TodoModel todo;

  @override
  ConsumerState<TodosItem> createState() => _TodosItemState();
}

class _TodosItemState extends ConsumerState<TodosItem> {
  Future<void> _delete() async {
    final todoViewModel =
        ref.read(todoViewModelProvider(TodoActivity.delete.name).notifier);
    final success = await todoViewModel.delete(todoId: widget.todo.id!);
    if (success && mounted) {
      context.pop();
    }
  }

  void _showActionSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: false,
            onPressed: () {
              context.pop();
              context.goNamed(
                AppRoute.editTodo.name,
                pathParameters: {'id': widget.todo.id!},
                extra: widget.todo,
              );
            },
            child: const Text('Edit'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              context.pop();
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Delete task?'),
                  content: const Text(
                    'Task will be permanently removed from your account',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: _delete,
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Delete'),
          ),
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      todoViewModelProvider(TodoActivity.delete.name),
      (_, state) => state.showAlertDialogOnError(context),
    );
    return Card.outlined(
      child: InkWell(
        onTap: () => context.goNamed(
          AppRoute.editTodo.name,
          pathParameters: {'id': widget.todo.id!},
          extra: widget.todo,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.s16),
          child: Row(
            children: [
              widget.todo.status
                  ? const Icon(
                      Icons.check_circle,
                      size: Sizes.iconMd,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.circle_outlined,
                      size: Sizes.iconMd,
                    ),
              gapW16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.todo.title),
                    gapH4,
                    Text(widget.todo.description),
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
                onPressed: () => _showActionSheet(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
