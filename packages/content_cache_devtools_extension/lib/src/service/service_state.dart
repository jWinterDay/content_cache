import 'service_cache_data.dart';

class ServiceState {
  ServiceState({
    this.date,
    this.message,
    this.contentCacheData = const <String, ServiceCacheData>{},
  });

  final Map<String, ServiceCacheData> contentCacheData;
  final String? message;
  final DateTime? date;
}
