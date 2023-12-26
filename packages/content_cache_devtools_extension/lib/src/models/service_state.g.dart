// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceStateImpl _$$ServiceStateImplFromJson(Map<String, dynamic> json) => _$ServiceStateImpl(
      contentCacheData: (json['contentCacheData'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, ServiceCacheData.fromJson(e as Map<String, dynamic>)),
          ) ??
          const <String, ServiceCacheData>{},
      message: json['message'] as String?,
      date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
      showExpired: json['showExpired'] as bool? ?? true,
      expiredContentCacheData: (json['expiredContentCacheData'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, ServiceCacheData.fromJson(e as Map<String, dynamic>)),
          ) ??
          const <String, ServiceCacheData>{},
      eventData: json['eventData'] as String?,
    );

Map<String, dynamic> _$$ServiceStateImplToJson(_$ServiceStateImpl instance) => <String, dynamic>{
      'contentCacheData': instance.contentCacheData.map((k, e) => MapEntry(k, e.toJson())),
      'message': instance.message,
      'date': instance.date?.toIso8601String(),
      'showExpired': instance.showExpired,
      'expiredContentCacheData': instance.expiredContentCacheData.map((k, e) => MapEntry(k, e.toJson())),
      'eventData': instance.eventData,
    };
