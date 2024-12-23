// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoViewModelHash() => r'99676dc1089e672736b77f7b4ba25a7e36771c1a';

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

abstract class _$TodoViewModel extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final String activity;

  FutureOr<void> build(
    String activity,
  );
}

/// See also [TodoViewModel].
@ProviderFor(TodoViewModel)
const todoViewModelProvider = TodoViewModelFamily();

/// See also [TodoViewModel].
class TodoViewModelFamily extends Family<AsyncValue<void>> {
  /// See also [TodoViewModel].
  const TodoViewModelFamily();

  /// See also [TodoViewModel].
  TodoViewModelProvider call(
    String activity,
  ) {
    return TodoViewModelProvider(
      activity,
    );
  }

  @override
  TodoViewModelProvider getProviderOverride(
    covariant TodoViewModelProvider provider,
  ) {
    return call(
      provider.activity,
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
  String? get name => r'todoViewModelProvider';
}

/// See also [TodoViewModel].
class TodoViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TodoViewModel, void> {
  /// See also [TodoViewModel].
  TodoViewModelProvider(
    String activity,
  ) : this._internal(
          () => TodoViewModel()..activity = activity,
          from: todoViewModelProvider,
          name: r'todoViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todoViewModelHash,
          dependencies: TodoViewModelFamily._dependencies,
          allTransitiveDependencies:
              TodoViewModelFamily._allTransitiveDependencies,
          activity: activity,
        );

  TodoViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.activity,
  }) : super.internal();

  final String activity;

  @override
  FutureOr<void> runNotifierBuild(
    covariant TodoViewModel notifier,
  ) {
    return notifier.build(
      activity,
    );
  }

  @override
  Override overrideWith(TodoViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: TodoViewModelProvider._internal(
        () => create()..activity = activity,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        activity: activity,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TodoViewModel, void> createElement() {
    return _TodoViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoViewModelProvider && other.activity == activity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, activity.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TodoViewModelRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `activity` of this provider.
  String get activity;
}

class _TodoViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TodoViewModel, void>
    with TodoViewModelRef {
  _TodoViewModelProviderElement(super.provider);

  @override
  String get activity => (origin as TodoViewModelProvider).activity;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
