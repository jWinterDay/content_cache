import 'package:di_visualizer_annotation/di_visualizer_annotation.dart';

@diService
abstract class ContentCache {
  // ValueNotifier<List<String>> get things; // = ValueNotifier<List<String>>(_things);

  Stream<Object> get onChangeStream;

  void save<T>(Object key, T content, {Duration ttl});

  bool isExists(Object key);

  T? retrieve<T>(Object key);

  T retrieveOrDefault<T>(Object key, T defaultVal);

  void clearAll();

  void remove(Object key);

  void dispose();
}
