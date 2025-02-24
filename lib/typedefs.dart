import 'package:flutter/material.dart';

typedef AsyncVoidCallback = AsyncCallback<void>;
typedef AsyncCallback<T> = Future<T> Function();
typedef OnChangedCallback<T> = void Function(T newValue);
typedef ValidatorCallback<T> = String? Function(T newValue);
typedef SetterCallback<T> = void Function(T newValue);
typedef DecoratorBuilderCallback = Widget Function(Widget child);
typedef AsyncBuilderCallback<T> = Widget Function(Future<T> future);
typedef OnDoneLoadingCallback<T> = void Function(T value);
