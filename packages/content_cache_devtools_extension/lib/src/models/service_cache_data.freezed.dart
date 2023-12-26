// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_cache_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ServiceCacheData _$ServiceCacheDataFromJson(Map<String, dynamic> json) {
  return _ServiceCacheData.fromJson(json);
}

/// @nodoc
mixin _$ServiceCacheData {
  String get content => throw _privateConstructorUsedError;
  int get ttl => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceCacheDataCopyWith<ServiceCacheData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceCacheDataCopyWith<$Res> {
  factory $ServiceCacheDataCopyWith(ServiceCacheData value, $Res Function(ServiceCacheData) then) =
      _$ServiceCacheDataCopyWithImpl<$Res, ServiceCacheData>;
  @useResult
  $Res call({String content, int ttl, String date});
}

/// @nodoc
class _$ServiceCacheDataCopyWithImpl<$Res, $Val extends ServiceCacheData> implements $ServiceCacheDataCopyWith<$Res> {
  _$ServiceCacheDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? ttl = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      ttl: null == ttl
          ? _value.ttl
          : ttl // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceCacheDataImplCopyWith<$Res> implements $ServiceCacheDataCopyWith<$Res> {
  factory _$$ServiceCacheDataImplCopyWith(_$ServiceCacheDataImpl value, $Res Function(_$ServiceCacheDataImpl) then) =
      __$$ServiceCacheDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content, int ttl, String date});
}

/// @nodoc
class __$$ServiceCacheDataImplCopyWithImpl<$Res> extends _$ServiceCacheDataCopyWithImpl<$Res, _$ServiceCacheDataImpl>
    implements _$$ServiceCacheDataImplCopyWith<$Res> {
  __$$ServiceCacheDataImplCopyWithImpl(_$ServiceCacheDataImpl _value, $Res Function(_$ServiceCacheDataImpl) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? ttl = null,
    Object? date = null,
  }) {
    return _then(_$ServiceCacheDataImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      ttl: null == ttl
          ? _value.ttl
          : ttl // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceCacheDataImpl implements _ServiceCacheData {
  const _$ServiceCacheDataImpl({required this.content, required this.ttl, required this.date});

  factory _$ServiceCacheDataImpl.fromJson(Map<String, dynamic> json) => _$$ServiceCacheDataImplFromJson(json);

  @override
  final String content;
  @override
  final int ttl;
  @override
  final String date;

  @override
  String toString() {
    return 'ServiceCacheData(content: $content, ttl: $ttl, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceCacheDataImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.ttl, ttl) || other.ttl == ttl) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, content, ttl, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceCacheDataImplCopyWith<_$ServiceCacheDataImpl> get copyWith =>
      __$$ServiceCacheDataImplCopyWithImpl<_$ServiceCacheDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceCacheDataImplToJson(
      this,
    );
  }
}

abstract class _ServiceCacheData implements ServiceCacheData {
  const factory _ServiceCacheData({required final String content, required final int ttl, required final String date}) =
      _$ServiceCacheDataImpl;

  factory _ServiceCacheData.fromJson(Map<String, dynamic> json) = _$ServiceCacheDataImpl.fromJson;

  @override
  String get content;
  @override
  int get ttl;
  @override
  String get date;
  @override
  @JsonKey(ignore: true)
  _$$ServiceCacheDataImplCopyWith<_$ServiceCacheDataImpl> get copyWith => throw _privateConstructorUsedError;
}
