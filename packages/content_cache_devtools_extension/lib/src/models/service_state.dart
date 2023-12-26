import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:content_cache_devtools_extension/src/index.dart';

part 'service_state.freezed.dart';
part 'service_state.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  genericArgumentFactories: false,
  equal: true,
  when: FreezedWhenOptions.none,
  map: FreezedMapOptions.none,
)
class ServiceState with _$ServiceState {
  const factory ServiceState({
    @Default(<String, ServiceCacheData>{}) Map<String, ServiceCacheData> contentCacheData,
    String? message,
    DateTime? fetchDate,

    // custom
    // @Default(true) bool showExpired,
    // @Default(<String, ServiceCacheData>{}) Map<String, ServiceCacheData> expiredContentCacheData,
    // String? eventData,
  }) = _ServiceState;

  factory ServiceState.fromJson(Map<String, dynamic> json) => _$ServiceStateFromJson(json);
}
