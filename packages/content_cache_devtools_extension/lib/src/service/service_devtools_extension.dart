// Copyright 2023 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print

import 'dart:async';

import 'package:content_cache_devtools_extension/src/service/service_cache_data.dart';
import 'package:content_cache_devtools_extension/src/service/service_runner.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:devtools_app_shared/ui.dart' as dtui;
import 'service_state.dart';

class ServiceDevtoolsExtension extends StatefulWidget {
  const ServiceDevtoolsExtension({super.key});

  @override
  State createState() => _ServiceDevtoolsExtensionState();
}

class _ServiceDevtoolsExtensionState extends State<ServiceDevtoolsExtension> {
  late final ServiceRunner _runner = ServiceRunner();

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
                Expanded(
                  child: ElevatedButton(
                    onPressed: _runner.fetchAll,
                    child: const Text('Fetch all'),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _runner.clear(null),
                    child: const Text('Clear all'),
                  ),
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
                          child: Column(
                            children: <Widget>[
                              // title and buttons
                              Row(
                                children: <Widget>[
                                  // key name
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: Text(
                                        key,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.blue,
                                            ),
                                      ),
                                    ),
                                  ),

                                  // remains
                                  if (data != null) ...<Widget>[
                                    // remains
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

                                  // clear
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: IconButton(
                                      tooltip: 'Remove from contentCache',
                                      onPressed: () {
                                        _runner.clear(key);
                                      },
                                      icon: const Icon(Icons.delete_forever_outlined),
                                    ),
                                  ),

                                  // copy all
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: IconButton(
                                      tooltip: 'Copy content',
                                      onPressed: data == null
                                          ? null
                                          : () {
                                              Clipboard.setData(ClipboardData(text: data.content));
                                            },
                                      icon: const Icon(Icons.copy),
                                    ),
                                  ),
                                ],
                              ),

                              // content
                              if (data != null) ...<Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text('date: ${data.date}'),
                                    ),
                                    Text('ttl(sec): ${data.ttl}'),
                                  ],
                                ),

                                //
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: ExpandableText(
                                    data.content,
                                    expandText: 'show more',
                                    collapseText: 'show less',
                                    maxLines: 3,
                                    linkColor: Colors.blue,
                                  ),

                                  //  SelectableText(data.content),
                                ),
                              ],
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
