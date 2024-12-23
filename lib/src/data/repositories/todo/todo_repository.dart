import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/todo/todo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_repository.g.dart';

@Riverpod(keepAlive: true)
TodoRepository todoRepository(Ref ref) {
  final firestore = FirebaseFirestore.instance;
  return TodoRepository(firestore: firestore);
}

class TodoRepository {
  TodoRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  static String todoPath(String todoId) => 'todos/$todoId';

  static String todosPath() => 'todos';

  Future<void> create({required TodoModel todo}) async {
    try {
      final todoModel = {
        'uid': todo.uid,
        'title': todo.title,
        'description': todo.description,
        'status': todo.status,
      };
      await _firestore.collection(todosPath()).add(todoModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> update({required String todoId, required TodoModel todo}) async {
    try {
      final todoModel = {
        'uid': todo.uid,
        'title': todo.title,
        'description': todo.description,
        'status': todo.status,
      };
      await _firestore.doc(todoPath(todoId)).update(todoModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete({required String todoId}) async {
    try {
      await _firestore.doc(todoPath(todoId)).delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<TodoModel>> read({required String uid}) => query(uid: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Future<List<TodoModel>> fetch({required String uid}) async {
    final todos = await query(uid: uid).get();
    return todos.docs.map((doc) => doc.data()).toList();
  }

  Query<TodoModel> query({required String uid}) {
    try {
      return _firestore
          .collection(todosPath())
          .where('uid', isEqualTo: uid)
          .withConverter<TodoModel>(
            fromFirestore: (snapshot, _) {
              final json = {
                ...snapshot.data()!,
                'id': snapshot.id,
              };
              return TodoModel.fromJson(json);
            },
            toFirestore: (todo, _) => todo.toJson(),
          );
    } catch (e) {
      throw Exception(e);
    }
  }
}
