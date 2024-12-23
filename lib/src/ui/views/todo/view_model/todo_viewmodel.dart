import 'package:mvvm_riverpod_architecture/src/data/repositories/auth/auth_repository.dart';
import 'package:mvvm_riverpod_architecture/src/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/todo/todo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_viewmodel.g.dart';

enum TodoActivity {
  edit,
  delete,
}

@riverpod
class TodoViewModel extends _$TodoViewModel {
  late TodoRepository _todoRepository;
  late AuthRepository _authRepository;

  @override
  FutureOr<void> build(String activity) {
    _todoRepository = ref.read(todoRepositoryProvider);
    _authRepository = ref.read(authRepositoryProvider);
  }

  Future<bool> submit({
    String? todoId,
    required String title,
    required String description,
  }) async {
    state = const AsyncLoading();
    // Check User has logged
    final currentUser = _authRepository.currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }

    // Fetch Todos & Check Todo exists
    final todos = await _todoRepository.fetch(uid: currentUser.uid!);
    final hasTodo = todos
        .where((todo) =>
            todo.title.toLowerCase().contains(title.toLowerCase()) &&
            todo.id != todoId)
        .toList();
    if (hasTodo.isNotEmpty) {
      state = AsyncError(
        'Title already used. Please choose a different one.',
        StackTrace.current,
      );
      return false;
    }
    final todo = TodoModel(
      uid: currentUser.uid!,
      title: title,
      description: description,
      status: false,
    );
    if (todoId == null) {
      state = await AsyncValue.guard(
        () => _todoRepository.create(todo: todo),
      );
    } else {
      state = await AsyncValue.guard(
        () => _todoRepository.update(todoId: todoId, todo: todo),
      );
    }
    return state.hasError == false;
  }

  Future<bool> delete({required String todoId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _todoRepository.delete(todoId: todoId),
    );
    return state.hasError == false;
  }
}
