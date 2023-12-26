import 'package:content_cache_devtools_extension/src/index.dart';

extension ServiceStateX on ServiceState {
  Map<String, ServiceCacheData> get resultUiShownData {
    return showExpired ? contentCacheData : expiredContentCacheData;
  }
}
