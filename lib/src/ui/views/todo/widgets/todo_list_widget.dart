import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/todo/todo_model.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/todo/widgets/todo_item_widget.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/empty_data.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key, required this.todos});

  final List<TodoModel> todos;

  @override
  Widget build(BuildContext context) {
    return todos.isNotEmpty
        ? ListView.separated(
            itemCount: todos.length,
            separatorBuilder: (context, index) => gapH16,
            itemBuilder: (context, index) => TodoItemWidget(todo: todos[index]),
          )
        : const SingleChildScrollView(child: EmptyData());
  }
}
