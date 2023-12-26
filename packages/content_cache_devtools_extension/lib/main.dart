import 'package:content_cache_devtools_extension/src/index.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const DevToolsExtension(
      child: ContentCacheDevToolsExtension(),
    ),
  );
}
