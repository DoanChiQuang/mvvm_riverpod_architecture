import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/todo/todo_model.dart';
import 'package:mvvm_riverpod_architecture/src/routing/app_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/todo/view_model/todos_viewmodel.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/todo/widgets/todos_list_item.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/async_value_widget.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_center.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_search_bar.dart';

class TodosScreen extends ConsumerWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosStateViewModel = ref.watch(todosViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: Sizes.iconMd),
            onPressed: () => context.goNamed(AppRoute.addTodo.name),
          ),
        ],
      ),
      body: CustomCenter(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          children: [
            CustomSearchBar(
              data: const [],
              onChanged: (value) {},
            ),
            TodosContent(content: [
              AsyncValueWidget<List<TodoModel>>(
                value: todosStateViewModel,
                data: (todos) => TodosListItem(todos: todos),
              ),
              AsyncValueWidget<List<TodoModel>>(
                value: todosStateViewModel,
                data: (todos) {
                  final data = todos.where((item) => !item.status).toList();
                  return TodosListItem(todos: data);
                },
              ),
              AsyncValueWidget<List<TodoModel>>(
                value: todosStateViewModel,
                data: (todos) {
                  final data = todos.where((item) => item.status).toList();
                  return TodosListItem(todos: data);
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class TodosContent extends StatelessWidget {
  const TodosContent({super.key, required this.content});

  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Expanded(
        child: Column(
          children: [
            const TabBar(tabs: [
              Tab(text: 'All'),
              Tab(text: 'To-do'),
              Tab(text: 'Done'),
            ]),
            gapH16,
            Expanded(
              child: TabBarView(
                children: content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
