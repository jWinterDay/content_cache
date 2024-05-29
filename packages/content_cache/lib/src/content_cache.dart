import 'dart:async';

import 'package:di_visualizer_annotation/di_visualizer_annotation.dart';

class Event<T> {
  Event(
    this.name,
    this.content,
  );

  final String name;
  final T? content;
}

typedef EventHandler<T> = FutureOr<void> Function(
  T? content,
);

@diService
abstract class ContentCache {
  // Stream<Event<dynamic>> get onChangeStream;
  StreamSubscription<Event<T>> on<T>(String name, EventHandler<T> handler);

  void save<T>(String key, T content, {Duration ttl});

  bool isExists(String key);

  T? retrieve<T>(String key);

  T? retrieveOrDefault<T>(String key, T? defaultVal);

  void clearAll();

  void remove(String key);

  void dispose();
}
