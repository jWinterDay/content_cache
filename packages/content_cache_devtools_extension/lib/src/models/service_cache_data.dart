import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_cache_data.freezed.dart';
part 'service_cache_data.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  genericArgumentFactories: false,
  equal: true,
  when: FreezedWhenOptions.none,
  map: FreezedMapOptions.none,
)
class ServiceCacheData with _$ServiceCacheData {
  const factory ServiceCacheData({
    required String content,
    required int ttl,
    required String date,
  }) = _ServiceCacheData;

  factory ServiceCacheData.fromJson(Map<String, dynamic> json) => _$ServiceCacheDataFromJson(json);
}
