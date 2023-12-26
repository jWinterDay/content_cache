// Copyright 2023 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'package:devtools_app_shared/ui.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:devtools_app_shared/ui.dart';

import 'service_devtools_extension.dart';

class ContentCacheDevToolsExtension extends StatelessWidget {
  const ContentCacheDevToolsExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return const DevToolsExtension(
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ContentCache DevTools Extension'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: denseSpacing),
        child: ServiceDevtoolsExtension(),
      ),
    );
  }
}
