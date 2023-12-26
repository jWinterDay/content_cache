import 'dart:async';

import 'package:content_cache_devtools_extension/src/index.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceDevtoolsExtension extends StatefulWidget {
  const ServiceDevtoolsExtension({super.key});

  @override
  State createState() => _ServiceDevtoolsExtensionState();
}

class _ServiceDevtoolsExtensionState extends State<ServiceDevtoolsExtension> {
  late final ServiceRunner _runner = ServiceRunner();

  Timer? _fetchTimer;
  // bool _showExpired = true;

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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (state.date != null) Text(state.date.toString()),
            if (state.message != null) Text(state.message!),

            Text(
              '----expired === ${state.showExpired} filteredContentCacheData = ${state.expiredContentCacheData.keys} all = ${state.contentCacheData}',
            ),

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

                // show expired
                const SizedBox(width: 32),

                Row(
                  children: <Widget>[
                    const Text('Show Expired'),
                    Checkbox(
                      value: state.showExpired,
                      onChanged: (bool? val) {
                        _runner.toggleShowExpired();
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // if (_loading) const LinearProgressIndicator(),

            if (state.resultUiShownData.isEmpty)
              const Expanded(
                child: Text('ContentCache. No data'),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: state.resultUiShownData.length,
                  itemBuilder: (BuildContext _, int index) {
                    final String key = state.resultUiShownData.keys.elementAt(index);
                    final ServiceCacheData? data = state.resultUiShownData[key];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // title and buttons
                              Row(
                                children: <Widget>[
                                  // key name
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 12,
                                      bottom: 6,
                                    ),
                                    child: Text(
                                      key,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.blue,
                                          ),
                                    ),
                                  ),

                                  // remains
                                  if (data != null) ...<Widget>[
                                    Text(
                                      data.remainTtl >= 0
                                          ? 'remain(sec): ${data.remainTtl}'
                                          : 'expired',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                    ),
                                  ],

                                  const Spacer(),

                                  // actions
                                  ...<Widget>[
                                    // clear
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: IconButton(
                                        tooltip: 'Remove from contentCache',
                                        onPressed: () {
                                          _runner.clear(key);
                                        },
                                        icon: const Icon(Icons.delete_forever_outlined),
                                      ),
                                    ),

                                    // copy all
                                    IconButton(
                                      tooltip: 'Copy content',
                                      onPressed: data == null
                                          ? null
                                          : () {
                                              Clipboard.setData(ClipboardData(text: data.content));
                                            },
                                      icon: const Icon(Icons.copy),
                                    ),
                                  ],
                                ],
                              ),

                              // content
                              if (data != null) ...<Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text('create date: ${data.date}'),
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
