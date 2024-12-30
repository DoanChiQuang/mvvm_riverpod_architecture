import 'package:mvvm_riverpod_architecture/src/data/repositories/auth/auth_repository.dart';
import 'package:mvvm_riverpod_architecture/src/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/todo/todo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todos_viewmodel.g.dart';

enum TodosType {
  read,
  create,
  edit,
  delete,
}

@riverpod
class TodosViewModel extends _$TodosViewModel {
  late String _uid;
  late TodoRepository _todoRepository;
  late AuthRepository _authRepository;

  @override
  Future<List<TodoModel>> build(List<TodosType> type) async {
    _authRepository = ref.watch(authRepositoryProvider);
    _todoRepository = ref.watch(todoRepositoryProvider);
    _uid = _authRepository.currentUser!.uid!;
    return await _todoRepository.fetch(uid: _uid);
  }

  Future<void> read() async {
    state = const AsyncLoading();
    Stream<List<TodoModel>> stream = _todoRepository.read(uid: _uid);
    stream.listen(
      (todos) => state = AsyncData(todos),
      onError: (error, stackTrace) => state = AsyncError(error, stackTrace),
    );
  }

  Future<bool> create({
    required String title,
    required String description,
  }) async {
    state = const AsyncLoading();
    AsyncValue result;
    final todos = await _todoRepository.fetch(uid: _uid);
    final sameTodoTitle = todos
        .where((todo) => todo.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
    if (sameTodoTitle.isNotEmpty) {
      state = AsyncError(
        'Title already used. Please choose a different one.',
        StackTrace.current,
      );
      return false;
    }
    result = await AsyncValue.guard(
      () => _todoRepository.create(
        todo: TodoModel(
          uid: _uid,
          title: title,
          description: description,
          status: false,
        ),
      ),
    );
    if (result.hasError) {
      state = AsyncError(
        result.error.toString(),
        StackTrace.current,
      );
    }
    return result.hasError == false;
  }

  Future<bool> edit({
    required String todoId,
    required String title,
    required String description,
    required bool status,
  }) async {
    state = const AsyncLoading();
    AsyncValue result;
    final todos = await _todoRepository.fetch(uid: _uid);
    final sameTodoTitle = todos
        .where((todo) =>
            todo.title.toLowerCase().contains(title.toLowerCase()) &&
            todo.id != todoId)
        .toList();
    if (sameTodoTitle.isNotEmpty) {
      state = AsyncError(
        'Title already used. Please choose a different one.',
        StackTrace.current,
      );
      return false;
    }
    result = await AsyncValue.guard(
      () => _todoRepository.update(
        todoId: todoId,
        todo: TodoModel(
          uid: _uid,
          title: title,
          description: description,
          status: status,
        ),
      ),
    );
    if (result.hasError) {
      state = AsyncError(
        result.error.toString(),
        StackTrace.current,
      );
    }
    return result.hasError == false;
  }

  Future<bool> delete({required String todoId}) async {
    state = const AsyncLoading();
    AsyncValue result = await AsyncValue.guard(
      () => _todoRepository.delete(todoId: todoId),
    );
    if (result.hasError) {
      state = AsyncError(
        result.error.toString(),
        StackTrace.current,
      );
    }
    return result.hasError == false;
  }
}
