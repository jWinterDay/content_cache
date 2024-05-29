import 'dart:async';

import 'package:di_visualizer_annotation/di_visualizer_annotation.dart';

class Event<T> {
  Event(
    this.name,
    this.content,
  );

  final String name;
  final T? content;

  @override
  String toString() {
    return '$name: $content';
  }
}

typedef EventHandler<T> = FutureOr<void> Function(
  Event<T?> event,
  // T? content,
);

@diService
abstract class ContentCache {
  StreamSubscription<Event<T?>> on<T>(String name, EventHandler<T?> handler);

  void save<T>(String key, T content, {Duration ttl});

  bool isExists(String key);

  T? retrieve<T>(String key);

  T? retrieveOrDefault<T>(String key, T? defaultVal);

  void clearAll();

  void remove(String key);

  void dispose();
}
