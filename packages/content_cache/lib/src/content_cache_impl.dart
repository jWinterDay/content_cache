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
  final T? content;
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

    _clearTimer = Timer.periodic(const Duration(seconds: 1), (Timer _) {
      final DateTime now = DateTime.now();

      bool needNotify = false;

      final List<String> keys = <String>[...cache.keys];

      for (final String key in keys) {
        final Info<dynamic>? value = cache[key];

        if (value != null) {
          final bool isExpired = value.date.add(value.ttl).isBefore(now);
          if (isExpired) {
            needNotify = true;
            cache.remove(key);
          }
        }
      }

      if (needNotify) {
        _notify();
      }
    });
  }

  static ContentCacheImpl get instance => _instance;
  static final ContentCacheImpl _instance = ContentCacheImpl._();

  static bool _initialized = false;

  static const String _getAllName = 'ext.content_cache.getAll';
  // static const String _addNewName = 'ext.content_cache.addNew';
  static const String _clearName = 'ext.content_cache.clearAll';

  // final Map<String, StreamSubscription<dynamic>> _subscriptions = <String, StreamSubscription<dynamic>>{};
  // final List<StreamSubscription<dynamic>> _subscriptions = <StreamSubscription<dynamic>>[];

  Timer? _clearTimer;

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
      final Map<String, dynamic> fmt = cache.map((String key, Info<dynamic> value) {
        return MapEntry<String, dynamic>(
          key,
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
  StreamController<Event<dynamic>> onChangeStreamController = StreamController<Event<dynamic>>.broadcast();

  // @override
  // Stream<Event<dynamic>> get onChangeStream => onChangeStreamController.stream.asBroadcastStream();

  static const Duration _defaultTtl = Duration(seconds: 30);

  @visibleForTesting
  final Map<String, Info<dynamic>> cache = <String, Info<dynamic>>{};

  @override
  bool isExists(String key) {
    return cache.containsKey(key);
  }

  @override
  T? retrieve<T>(String key, {bool force = false}) {
    final Info<dynamic>? info = cache[key];

    if (info == null) {
      return null;
    }

    if (info.content is! T) {
      return null;
    }

    return info.content;
  }

  @override
  T? retrieveOrDefault<T>(String key, T? defaultVal) {
    final T? raw = retrieve(key);

    return raw ?? defaultVal;
  }

  @override
  void save<T>(String key, T? content, {Duration ttl = _defaultTtl}) {
    cache[key] = Info<T>(
      content,
      ttl: ttl,
    );

    onChangeStreamController.add(Event<T>(key, content));

    _notify();
  }

  @override
  void clearAll() {
    cache.clear();

    final List<String> keys = <String>[...cache.keys];

    for (final String key in keys) {
      onChangeStreamController.add(Event<dynamic>(key, null));
    }

    _notify();
  }

  @override
  void remove(String key) {
    cache.remove(key);

    onChangeStreamController.add(Event<dynamic>(key, null));

    _notify();
  }

  @mustCallSuper
  @override
  void dispose() {
    _clearTimer?.cancel();

    unawaited(onChangeStreamController.close());
  }

  void _notify({
    Map<dynamic, dynamic> data = const <dynamic, dynamic>{},
  }) {
    developer.postEvent('content_cache:content_cache_changed', data);
  }

  @override
  StreamSubscription<Event<T?>> on<T>(String name, EventHandler<T?> handler) {
    // ignore: cancel_subscriptions
    final StreamSubscription<Event<dynamic>> listener = onChangeStreamController.stream
        .where((Event<dynamic> event) {
          final dynamic raw = event.content;

          if (raw is! T?) {
            return false;
          }

          return event.name == name;
        })
        .cast<Event<T?>>()
        .listen((Event<T?> event) async {
          await handler(event);
        });

    return listener as StreamSubscription<Event<T?>>;
  }
}
