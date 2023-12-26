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
      fetchDate: json['fetchDate'] == null ? null : DateTime.parse(json['fetchDate'] as String),
    );

Map<String, dynamic> _$$ServiceStateImplToJson(_$ServiceStateImpl instance) => <String, dynamic>{
      'contentCacheData': instance.contentCacheData.map((k, e) => MapEntry(k, e.toJson())),
      'message': instance.message,
      'fetchDate': instance.fetchDate?.toIso8601String(),
    };
