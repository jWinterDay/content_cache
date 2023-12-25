// Copyright 2023 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print

import 'dart:async';

import 'package:content_cache_devtools_extension/src/service/service_cache_data.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:vm_service/vm_service.dart';

import 'service_state.dart';

class ServiceRunner extends ValueNotifier<ServiceState> {
  ServiceRunner() : super(ServiceState());

  Future<void> fetchAll() async {
    try {
      final Response response = await serviceManager.callServiceExtensionOnMainIsolate(
        'ext.content_cache.getAll',
      );

      final Map<String, dynamic> raw = response.json ?? <String, dynamic>{};

      final Map<String, ServiceCacheData> result = raw.map((String key, dynamic value) {
        final ServiceCacheData data = ServiceCacheData.fromJson(value);

        return MapEntry<String, ServiceCacheData>(key, data);
      });

      value = ServiceState(
        date: DateTime.now(),
        contentCacheData: result,
        message: 'Successfully fetched ${result.length} items',
      );
    } on Object catch (err) {
      value = ServiceState(
        date: DateTime.now(),
        message: 'Error $err',
      );
    }

    notifyListeners();
  }

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

      final Map<String, dynamic> raw = response.json ?? <String, dynamic>{};

      final Map<String, ServiceCacheData> result = raw.map((String key, dynamic value) {
        final ServiceCacheData data = ServiceCacheData.fromJson(value);

        return MapEntry<String, ServiceCacheData>(key, data);
      });

      value = ServiceState(
        date: DateTime.now(),
        contentCacheData: result,
        message: 'Successfully clear. Key: $key',
      );
    } on Object catch (err) {
      value = ServiceState(
        date: DateTime.now(),
        message: 'Error $err',
      );
    }

    notifyListeners();
  }
}
