import 'dart:async';

import 'package:content_cache_devtools_extension/src/index.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:vm_service/vm_service.dart';

Map<String, ServiceCacheData> _parseResult(Response response) {
  final Map<String, dynamic> raw = response.json ?? <String, dynamic>{};

  final Map<String, ServiceCacheData> result = raw.map((String key, dynamic value) {
    final ServiceCacheData data = ServiceCacheData.fromJson(value);

    return MapEntry<String, ServiceCacheData>(key, data);
  });

  return result.orderByDate();
}

class ServiceRunner extends ValueNotifier<ServiceState> {
  ServiceRunner() : super(const ServiceState());

  StreamSubscription<Event>? _vmServiceSubscription;

  // subscribe
  void subscribeExtension() {
    _vmServiceSubscription = serviceManager.service?.onExtensionEvent.where((Event event) {
      return event.extensionKind == 'content_cache:content_cache_changed';
    }).listen((Event event) {
      fetchAll();
    });
  }

  // Map<String, ServiceCacheData> get _expired {
  //   return <String, ServiceCacheData>{...value.contentCacheData}..removeWhere((String key, ServiceCacheData value) {
  //       final bool itemExpired = value.remainTtl < 0;

  //       return itemExpired;
  //     });
  // }

  // void toggleShowExpired() {
  //   final bool nextShowExpired = !value.showExpired;

  //   value = value.copyWith(
  //     showExpired: nextShowExpired,
  //     expiredContentCacheData: nextShowExpired ? <String, ServiceCacheData>{} : _expired,
  //   );

  //   notifyListeners();
  // }

  Future<void> fetchAll() async {
    try {
      final Response response = await serviceManager.callServiceExtensionOnMainIsolate(
        'ext.content_cache.getAll',
      );
      final Map<String, ServiceCacheData> result = await compute(_parseResult, response);

      value = value.copyWith(
        fetchDate: DateTime.now(),
        contentCacheData: result,
        // expiredContentCacheData: _expired,
        message: 'Successfully fetched ${result.length} items',
      );
    } on Object catch (err) {
      value = ServiceState(
        fetchDate: DateTime.now(),
        message: 'Error $err',
      );
    }

    notifyListeners();
  }

  // Future<void> addNew() async {
  //   try {
  //     final Response response = await serviceManager.callServiceExtensionOnMainIsolate(
  //       'ext.content_cache.addNew',
  //     );
  //     // final Map<String, ServiceCacheData> result = await compute(_parseResult, response);

  //     // // fake
  //     // // final Map<String, ServiceCacheData> result = <String, ServiceCacheData>{
  //     // //   'test1': ServiceCacheData(
  //     // //     content: List.generate(500, (index) => '$index').join(),
  //     // //     ttl: 666,
  //     // //     date: DateTime.now().toString(),
  //     // //   ),
  //     // // };

  //     // value = value.copyWith(
  //     //   date: DateTime.now(),
  //     //   contentCacheData: result,
  //     //   expiredContentCacheData: _expired,
  //     //   message: 'Successfully fetched ${result.length} items',
  //     // );
  //   } on Object catch (err) {
  //     value = ServiceState(
  //       date: DateTime.now(),
  //       message: 'Error $err',
  //     );
  //   }

  //   notifyListeners();
  // }

  Future<void> clear(String? key) async {
    try {
      final Response response = await serviceManager.callServiceExtensionOnMainIsolate(
        'ext.content_cache.clearAll',
        args: key == null
            ? null
            : <String, dynamic>{
                'key': key,
              },
      );

      // final Map<String, ServiceCacheData> result = _parseResult(response);
      final Map<String, ServiceCacheData> result = await compute(_parseResult, response);

      value = value.copyWith(
        fetchDate: DateTime.now(),
        contentCacheData: result,
        // expiredContentCacheData: _expired,
        message: 'Successfully clear. Key: $key',
      );
    } on Object catch (err) {
      value = value.copyWith(
        fetchDate: DateTime.now(),
        message: 'Error $err',
      );
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _vmServiceSubscription?.cancel();

    super.dispose();
  }
}
