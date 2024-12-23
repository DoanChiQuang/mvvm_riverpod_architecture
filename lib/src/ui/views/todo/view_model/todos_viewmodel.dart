import 'package:mvvm_riverpod_architecture/src/data/repositories/auth/auth_repository.dart';
import 'package:mvvm_riverpod_architecture/src/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/todo/todo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todos_viewmodel.g.dart';

@riverpod
class TodosViewModel extends _$TodosViewModel {
  late TodoRepository _todoRepository;
  late AuthRepository _authRepository;

  @override
  Stream<List<TodoModel>> build() {
    _authRepository = ref.read(authRepositoryProvider);
    final uid = _authRepository.currentUser!.uid;
    _todoRepository = ref.read(todoRepositoryProvider);
    return _todoRepository.read(uid: uid!);
  }
}
