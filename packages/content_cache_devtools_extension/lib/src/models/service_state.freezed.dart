// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ServiceState _$ServiceStateFromJson(Map<String, dynamic> json) {
  return _ServiceState.fromJson(json);
}

/// @nodoc
mixin _$ServiceState {
  Map<String, ServiceCacheData> get contentCacheData => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError; // custom
  bool get showExpired => throw _privateConstructorUsedError;
  Map<String, ServiceCacheData> get expiredContentCacheData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceStateCopyWith<ServiceState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceStateCopyWith<$Res> {
  factory $ServiceStateCopyWith(ServiceState value, $Res Function(ServiceState) then) = _$ServiceStateCopyWithImpl<$Res, ServiceState>;
  @useResult
  $Res call(
      {Map<String, ServiceCacheData> contentCacheData,
      String? message,
      DateTime? date,
      bool showExpired,
      Map<String, ServiceCacheData> expiredContentCacheData});
}

/// @nodoc
class _$ServiceStateCopyWithImpl<$Res, $Val extends ServiceState> implements $ServiceStateCopyWith<$Res> {
  _$ServiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentCacheData = null,
    Object? message = freezed,
    Object? date = freezed,
    Object? showExpired = null,
    Object? expiredContentCacheData = null,
  }) {
    return _then(_value.copyWith(
      contentCacheData: null == contentCacheData
          ? _value.contentCacheData
          : contentCacheData // ignore: cast_nullable_to_non_nullable
              as Map<String, ServiceCacheData>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showExpired: null == showExpired
          ? _value.showExpired
          : showExpired // ignore: cast_nullable_to_non_nullable
              as bool,
      expiredContentCacheData: null == expiredContentCacheData
          ? _value.expiredContentCacheData
          : expiredContentCacheData // ignore: cast_nullable_to_non_nullable
              as Map<String, ServiceCacheData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceStateImplCopyWith<$Res> implements $ServiceStateCopyWith<$Res> {
  factory _$$ServiceStateImplCopyWith(_$ServiceStateImpl value, $Res Function(_$ServiceStateImpl) then) =
      __$$ServiceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, ServiceCacheData> contentCacheData,
      String? message,
      DateTime? date,
      bool showExpired,
      Map<String, ServiceCacheData> expiredContentCacheData});
}

/// @nodoc
class __$$ServiceStateImplCopyWithImpl<$Res> extends _$ServiceStateCopyWithImpl<$Res, _$ServiceStateImpl>
    implements _$$ServiceStateImplCopyWith<$Res> {
  __$$ServiceStateImplCopyWithImpl(_$ServiceStateImpl _value, $Res Function(_$ServiceStateImpl) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentCacheData = null,
    Object? message = freezed,
    Object? date = freezed,
    Object? showExpired = null,
    Object? expiredContentCacheData = null,
  }) {
    return _then(_$ServiceStateImpl(
      contentCacheData: null == contentCacheData
          ? _value._contentCacheData
          : contentCacheData // ignore: cast_nullable_to_non_nullable
              as Map<String, ServiceCacheData>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showExpired: null == showExpired
          ? _value.showExpired
          : showExpired // ignore: cast_nullable_to_non_nullable
              as bool,
      expiredContentCacheData: null == expiredContentCacheData
          ? _value._expiredContentCacheData
          : expiredContentCacheData // ignore: cast_nullable_to_non_nullable
              as Map<String, ServiceCacheData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceStateImpl implements _ServiceState {
  const _$ServiceStateImpl(
      {final Map<String, ServiceCacheData> contentCacheData = const <String, ServiceCacheData>{},
      this.message,
      this.date,
      this.showExpired = true,
      final Map<String, ServiceCacheData> expiredContentCacheData = const <String, ServiceCacheData>{}})
      : _contentCacheData = contentCacheData,
        _expiredContentCacheData = expiredContentCacheData;

  factory _$ServiceStateImpl.fromJson(Map<String, dynamic> json) => _$$ServiceStateImplFromJson(json);

  final Map<String, ServiceCacheData> _contentCacheData;
  @override
  @JsonKey()
  Map<String, ServiceCacheData> get contentCacheData {
    if (_contentCacheData is EqualUnmodifiableMapView) return _contentCacheData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_contentCacheData);
  }

  @override
  final String? message;
  @override
  final DateTime? date;
// custom
  @override
  @JsonKey()
  final bool showExpired;
  final Map<String, ServiceCacheData> _expiredContentCacheData;
  @override
  @JsonKey()
  Map<String, ServiceCacheData> get expiredContentCacheData {
    if (_expiredContentCacheData is EqualUnmodifiableMapView) return _expiredContentCacheData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_expiredContentCacheData);
  }

  @override
  String toString() {
    return 'ServiceState(contentCacheData: $contentCacheData, message: $message, date: $date, showExpired: $showExpired, expiredContentCacheData: $expiredContentCacheData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceStateImpl &&
            const DeepCollectionEquality().equals(other._contentCacheData, _contentCacheData) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.showExpired, showExpired) || other.showExpired == showExpired) &&
            const DeepCollectionEquality().equals(other._expiredContentCacheData, _expiredContentCacheData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_contentCacheData), message, date, showExpired,
      const DeepCollectionEquality().hash(_expiredContentCacheData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceStateImplCopyWith<_$ServiceStateImpl> get copyWith => __$$ServiceStateImplCopyWithImpl<_$ServiceStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceStateImplToJson(
      this,
    );
  }
}

abstract class _ServiceState implements ServiceState {
  const factory _ServiceState(
      {final Map<String, ServiceCacheData> contentCacheData,
      final String? message,
      final DateTime? date,
      final bool showExpired,
      final Map<String, ServiceCacheData> expiredContentCacheData}) = _$ServiceStateImpl;

  factory _ServiceState.fromJson(Map<String, dynamic> json) = _$ServiceStateImpl.fromJson;

  @override
  Map<String, ServiceCacheData> get contentCacheData;
  @override
  String? get message;
  @override
  DateTime? get date;
  @override // custom
  bool get showExpired;
  @override
  Map<String, ServiceCacheData> get expiredContentCacheData;
  @override
  @JsonKey(ignore: true)
  _$$ServiceStateImplCopyWith<_$ServiceStateImpl> get copyWith => throw _privateConstructorUsedError;
}
