// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todosViewModelHash() => r'dd0b5e9698297fd684ef8c25e6eafd6bec870e7c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TodosViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<TodoModel>> {
  late final List<TodosType> type;

  FutureOr<List<TodoModel>> build(
    List<TodosType> type,
  );
}

/// See also [TodosViewModel].
@ProviderFor(TodosViewModel)
const todosViewModelProvider = TodosViewModelFamily();

/// See also [TodosViewModel].
class TodosViewModelFamily extends Family<AsyncValue<List<TodoModel>>> {
  /// See also [TodosViewModel].
  const TodosViewModelFamily();

  /// See also [TodosViewModel].
  TodosViewModelProvider call(
    List<TodosType> type,
  ) {
    return TodosViewModelProvider(
      type,
    );
  }

  @override
  TodosViewModelProvider getProviderOverride(
    covariant TodosViewModelProvider provider,
  ) {
    return call(
      provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'todosViewModelProvider';
}

/// See also [TodosViewModel].
class TodosViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    TodosViewModel, List<TodoModel>> {
  /// See also [TodosViewModel].
  TodosViewModelProvider(
    List<TodosType> type,
  ) : this._internal(
          () => TodosViewModel()..type = type,
          from: todosViewModelProvider,
          name: r'todosViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todosViewModelHash,
          dependencies: TodosViewModelFamily._dependencies,
          allTransitiveDependencies:
              TodosViewModelFamily._allTransitiveDependencies,
          type: type,
        );

  TodosViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final List<TodosType> type;

  @override
  FutureOr<List<TodoModel>> runNotifierBuild(
    covariant TodosViewModel notifier,
  ) {
    return notifier.build(
      type,
    );
  }

  @override
  Override overrideWith(TodosViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: TodosViewModelProvider._internal(
        () => create()..type = type,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TodosViewModel, List<TodoModel>>
      createElement() {
    return _TodosViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodosViewModelProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TodosViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<List<TodoModel>> {
  /// The parameter `type` of this provider.
  List<TodosType> get type;
}

class _TodosViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TodosViewModel,
        List<TodoModel>> with TodosViewModelRef {
  _TodosViewModelProviderElement(super.provider);

  @override
  List<TodosType> get type => (origin as TodosViewModelProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
