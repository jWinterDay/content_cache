[![Pub Version](https://badgen.net/pub/v/content_cache)](https://pub.dev/packages/content_cache/)
[![Dart SDK Version](https://badgen.net/pub/sdk-version/content_cache)](https://pub.dev/packages/content_cache/)
[![Pub popularity](https://badgen.net/pub/popularity/content_cache)](https://pub.dev/packages/content_cache/score)


# Content Cache
simple key-value cache with Devtools Extension support

# Usage
## 1. install
dart pub add content_cache

## 2. methods
```dart
Stream<Object> get onChangeStream
void save<T>(Object key, T content, {Duration ttl})
bool isExists(Object key)
T? retrieve<T>(Object key)
T retrieveOrDefault<T>(Object key, T defaultVal)
void clearAll()
void remove(Object key)
void dispose()
```

# Devtools
also this package allows you to see the cache data real-time

![Screenshot](images/devtools_1.png)


# Example

```dart
import 'package:content_cache/content_cache.dart';

void main() {
    final ContentCache contentCache = ContentCacheImpl.instance;

    contentCache.save('counterKey', 'test1');
}
```