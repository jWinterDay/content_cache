import 'package:content_cache_devtools_extension/src/index.dart';

extension MapX on Map<String, ServiceCacheData> {
  /// Order by values
  Map<String, ServiceCacheData> orderByDate() {
    return Map<String, ServiceCacheData>.fromEntries(
      entries.toList()
        ..sort(
          (MapEntry<String, ServiceCacheData> a, MapEntry<String, ServiceCacheData> b) {
            return b.value.date.compareTo(a.value.date);
          },
        ),
    );
  }
}
