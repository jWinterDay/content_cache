// Copyright 2023 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print

import 'dart:async';

import 'package:content_cache_devtools_extension/src/service/service_cache_data.dart';
import 'package:content_cache_devtools_extension/src/service/service_runner.dart';
import 'package:flutter/material.dart';

import 'service_state.dart';

class ServiceDevtoolsExtension extends StatefulWidget {
  const ServiceDevtoolsExtension({super.key});

  @override
  State createState() => _ServiceDevtoolsExtensionState();
}

class _ServiceDevtoolsExtensionState extends State<ServiceDevtoolsExtension> {
  final ServiceRunner _runner = ServiceRunner();

  Timer? _fetchTimer;

  @override
  void initState() {
    super.initState();

    _runner.fetchAll();

    _fetchTimer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (!mounted) {
        return;
      }

      _runner.fetchAll();
    });
  }

  @override
  void didUpdateWidget(ServiceDevtoolsExtension oldWidget) {
    super.didUpdateWidget(oldWidget);

    unawaited(_runner.fetchAll());
  }

  @override
  void dispose() {
    _fetchTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ServiceState>(
      valueListenable: _runner,
      builder: (BuildContext _, ServiceState state, Widget? child) {
        //
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (state.date != null) Text(state.date.toString()),
            if (state.message != null) Text(state.message!),

            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: _runner.fetchAll,
                  child: const Text('Fetch all'),
                ),
                const SizedBox(width: 32),
                ElevatedButton(
                  onPressed: () => _runner.clear(null),
                  child: const Text('Clear all'),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // if (_loading) const LinearProgressIndicator(),

            if (state.contentCacheData.isEmpty)
              const Expanded(
                child: Text('ContentCache. No data'),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: state.contentCacheData.length,
                  itemBuilder: (BuildContext _, int index) {
                    final String key = state.contentCacheData.keys.elementAt(index);
                    final ServiceCacheData? data = state.contentCacheData[key];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // key name
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: Text(
                                        key,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                      ),
                                    ),

                                    if (data == null) ...<Widget>[
                                      const Placeholder(fallbackHeight: 20),
                                    ] else ...<Widget>[
                                      // remain
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          data.remainTtl >= 0
                                              ? 'remain(sec): ${data.remainTtl}'
                                              : 'expired',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                        ),
                                      ),
                                    ],

                                    // content
                                    Text(data.toString()),
                                  ],
                                ),
                              ),

                              // clear
                              IconButton(
                                onPressed: () {
                                  _runner.clear(key);
                                },
                                icon: const Icon(Icons.delete_forever_outlined),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
