import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/todo/todo_model.dart';
import 'package:mvvm_riverpod_architecture/src/routing/app_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/todo/view_model/todos_viewmodel.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/todo/widgets/todo_list_widget.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/async_value_widget.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_center.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_search_bar.dart';

class ListTodoScreen extends ConsumerStatefulWidget {
  const ListTodoScreen({super.key});

  @override
  ConsumerState<ListTodoScreen> createState() => _ListTodoScreenState();
}

class _ListTodoScreenState extends ConsumerState<ListTodoScreen> {
  late TodosViewModel _todosViewModel;
  late String _search;

  List<TodoModel> onSearch(List<TodoModel> todos) => todos
      .where((item) =>
          item.title.toLowerCase().contains(_search.toLowerCase()) ||
          item.description.toLowerCase().contains(_search.toLowerCase()))
      .toList();

  @override
  void initState() {
    super.initState();
    _search = '';
    _todosViewModel = ref.read(todosViewModelProvider(const [
      TodosType.read,
    ]).notifier);
    Future(() {
      _todosViewModel.read();
    });
  }

  @override
  Widget build(BuildContext context) {
    final todosState = ref.watch(todosViewModelProvider(const [
      TodosType.read,
    ]));
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
            CustomSearchBar(onChanged: (value) {
              setState(() => _search = value);
            }),
            TodoContent(
              content: [
                AsyncValueWidget<List<TodoModel>>(
                  value: todosState,
                  data: (todos) {
                    final data = onSearch(todos);
                    return TodoListWidget(todos: data);
                  },
                ),
                AsyncValueWidget<List<TodoModel>>(
                  value: todosState,
                  data: (todos) {
                    final data = onSearch(todos);
                    return TodoListWidget(
                      todos: data.where((item) => !item.status).toList(),
                    );
                  },
                ),
                AsyncValueWidget<List<TodoModel>>(
                  value: todosState,
                  data: (todos) {
                    final data = onSearch(todos);
                    return TodoListWidget(
                      todos: data.where((item) => item.status).toList(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TodoContent extends StatelessWidget {
  const TodoContent({super.key, required this.content});

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
