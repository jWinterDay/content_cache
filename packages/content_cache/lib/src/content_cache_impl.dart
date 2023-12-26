import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:content_cache/content_cache.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

@visibleForTesting
class Info<T> {
  Info(
    this.content, {
    required this.ttl,
  }) : date = DateTime.now();

  final DateTime date;
  final T content;
  final Duration ttl;

  @override
  String toString() {
    return 'date: $date\nttl(sec): ${ttl.inSeconds}\ncontent: $content';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.toString(),
      'ttl': ttl.inSeconds,
      'content': content.toString(),
    };
  }
}

class ContentCacheImpl implements ContentCache {
  ContentCacheImpl._() {
    _initExtension();
  }

  static ContentCacheImpl get instance => _instance;
  static final ContentCacheImpl _instance = ContentCacheImpl._();

  static bool _initialized = false;

  static const String _getAllName = 'ext.content_cache.getAll';
  // static const String _addName = 'ext.content_cache.add';
  static const String _clearName = 'ext.content_cache.clearAll';

  ServiceExtensionResponse _serviceResponse() {
    // final DateTime now = DateTime.now();

    // check expired
    // final Map<Object, Info<dynamic>> tmpCache = <Object, Info<dynamic>>{...cache};
    // tmpCache.forEach((Object key, Info<dynamic> value) {
    //   final bool isExpired = value.date.add(value.ttl).isBefore(now);
    //   if (isExpired) {
    //     cache.remove(key);
    //   }
    // });

    try {
      final Map<String, dynamic> fmt = cache.map((Object key, Info<dynamic> value) {
        return MapEntry<String, dynamic>(
          key.toString(),
          value.toMap(),
        );
      });

      return ServiceExtensionResponse.result(jsonEncode(fmt));
    } on Object catch (err) {
      return ServiceExtensionResponse.error(
        ServiceExtensionResponse.invalidParams,
        'err: $err',
      );
    }
  }

  void _initExtension() {
    if (!_initialized) {
      // get all
      registerExtension(_getAllName, (String method, Map<String, String> parameters) async {
        return _serviceResponse();
      });

      // clear all
      registerExtension(_clearName, (String method, Map<String, String> parameters) async {
        final String? key = parameters['key']?.toString();

        if (key == null) {
          clearAll();

          return ServiceExtensionResponse.result(jsonEncode(<String, dynamic>{}));
        }

        // delete by key
        remove(key);

        return _serviceResponse();
      });
    }

    _initialized = true;
  }

  @visibleForTesting
  StreamController<Object> onChangeStreamController = StreamController<Object>.broadcast();

  @override
  Stream<Object> get onChangeStream => onChangeStreamController.stream.asBroadcastStream();

  static const Duration _defaultTtl = Duration(seconds: 30);

  @visibleForTesting
  final Map<Object, Info<dynamic>> cache = <Object, Info<dynamic>>{};

  @override
  bool isExists(Object key) {
    return cache.containsKey(key);
  }

  @override
  T? retrieve<T>(Object key, {bool force = false}) {
    final Info<dynamic>? info = cache[key];

    if (info == null) {
      return null;
    }

    if (info.content is! T) {
      return null;
    }

    if (force) {
      return info.content;
    }

    final DateTime now = DateTime.now();

    final bool isExpired = info.date.add(info.ttl).isBefore(now);
    if (isExpired) {
      cache.remove(key);

      _notify();

      return null;
    }

    return info.content;
  }

  @override
  T retrieveOrDefault<T>(Object key, T defaultVal) {
    final T? raw = retrieve(key);

    return raw ?? defaultVal;
  }

  @override
  void save<T>(Object key, T content, {Duration ttl = _defaultTtl}) {
    cache[key] = Info<T>(
      content,
      ttl: ttl,
    );

    onChangeStreamController.add(key);

    _notify();
  }

  @override
  void clearAll() {
    // onChangeStreamController.add(null);

    cache.clear();

    _notify();
  }

  @override
  void remove(Object key) {
    cache.remove(key);
  }

  @override
  void dispose() {
    unawaited(onChangeStreamController.close());
  }

  void _notify({
    Map<dynamic, dynamic> data = const <dynamic, dynamic>{},
  }) {
    developer.postEvent('content_cache:content_cache_changed', data);

    // final Map<String, dynamic> fmt = cache.map((Object key, Info<dynamic> value) {
    //   return MapEntry<String, dynamic>(
    //     key.toString(),
    //     value.toString(),
    //     // json.encode(value.toMap()),
    //   );
    // });

    // // return ServiceExtensionResponse.result(jsonEncode(fmt));

    // postEvent('ext.content_cache.getAll', fmt);
  }
}
