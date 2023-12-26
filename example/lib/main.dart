import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:content_cache/content_cache.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  late ContentCache _contentCache;

  static String _key(int index) => 'counterKey_$index';

  @override
  void initState() {
    super.initState();

    _contentCache = ContentCacheImpl.instance;
  }

  void _incrementCounter() {
    final int nextCounter = _counter + 1;

    setState(() {
      _counter = nextCounter;
    });

    _contentCache.save(_key(nextCounter), nextCounter, ttl: const Duration(seconds: 15));
  }

  @override
  Widget build(BuildContext context) {
    return Provider<String>.value(
      value: 'test',
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              //
              // ContentCacheWidget(
              //   contentCache: _contentCache,
              // ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
