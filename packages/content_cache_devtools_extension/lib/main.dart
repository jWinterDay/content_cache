import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';

import 'src/content_cache_devtools_extension.dart';

void main() {
  runApp(
    // ContentCacheDevToolsExtension(),
    const DevToolsExtension(
      child: ContentCacheDevToolsExtension(),
    ),
  );
}
