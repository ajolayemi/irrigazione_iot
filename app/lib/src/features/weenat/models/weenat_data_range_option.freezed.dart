// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_data_range_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WeenatDataRangeOption {
  String get locKey => throw _privateConstructorUsedError;
  int get daysDifference => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeenatDataRangeOptionCopyWith<WeenatDataRangeOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeenatDataRangeOptionCopyWith<$Res> {
  factory $WeenatDataRangeOptionCopyWith(WeenatDataRangeOption value,
          $Res Function(WeenatDataRangeOption) then) =
      _$WeenatDataRangeOptionCopyWithImpl<$Res, WeenatDataRangeOption>;
  @useResult
  $Res call({String locKey, int daysDifference});
}

/// @nodoc
class _$WeenatDataRangeOptionCopyWithImpl<$Res,
        $Val extends WeenatDataRangeOption>
    implements $WeenatDataRangeOptionCopyWith<$Res> {
  _$WeenatDataRangeOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locKey = null,
    Object? daysDifference = null,
  }) {
    return _then(_value.copyWith(
      locKey: null == locKey
          ? _value.locKey
          : locKey // ignore: cast_nullable_to_non_nullable
              as String,
      daysDifference: null == daysDifference
          ? _value.daysDifference
          : daysDifference // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeenatDataRangeOptionImplCopyWith<$Res>
    implements $WeenatDataRangeOptionCopyWith<$Res> {
  factory _$$WeenatDataRangeOptionImplCopyWith(
          _$WeenatDataRangeOptionImpl value,
          $Res Function(_$WeenatDataRangeOptionImpl) then) =
      __$$WeenatDataRangeOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String locKey, int daysDifference});
}

/// @nodoc
class __$$WeenatDataRangeOptionImplCopyWithImpl<$Res>
    extends _$WeenatDataRangeOptionCopyWithImpl<$Res,
        _$WeenatDataRangeOptionImpl>
    implements _$$WeenatDataRangeOptionImplCopyWith<$Res> {
  __$$WeenatDataRangeOptionImplCopyWithImpl(_$WeenatDataRangeOptionImpl _value,
      $Res Function(_$WeenatDataRangeOptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locKey = null,
    Object? daysDifference = null,
  }) {
    return _then(_$WeenatDataRangeOptionImpl(
      locKey: null == locKey
          ? _value.locKey
          : locKey // ignore: cast_nullable_to_non_nullable
              as String,
      daysDifference: null == daysDifference
          ? _value.daysDifference
          : daysDifference // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$WeenatDataRangeOptionImpl extends _WeenatDataRangeOption {
  const _$WeenatDataRangeOptionImpl(
      {required this.locKey, required this.daysDifference})
      : super._();

  @override
  final String locKey;
  @override
  final int daysDifference;

  @override
  String toString() {
    return 'WeenatDataRangeOption(locKey: $locKey, daysDifference: $daysDifference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeenatDataRangeOptionImpl &&
            (identical(other.locKey, locKey) || other.locKey == locKey) &&
            (identical(other.daysDifference, daysDifference) ||
                other.daysDifference == daysDifference));
  }

  @override
  int get hashCode => Object.hash(runtimeType, locKey, daysDifference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeenatDataRangeOptionImplCopyWith<_$WeenatDataRangeOptionImpl>
      get copyWith => __$$WeenatDataRangeOptionImplCopyWithImpl<
          _$WeenatDataRangeOptionImpl>(this, _$identity);
}

abstract class _WeenatDataRangeOption extends WeenatDataRangeOption {
  const factory _WeenatDataRangeOption(
      {required final String locKey,
      required final int daysDifference}) = _$WeenatDataRangeOptionImpl;
  const _WeenatDataRangeOption._() : super._();

  @override
  String get locKey;
  @override
  int get daysDifference;
  @override
  @JsonKey(ignore: true)
  _$$WeenatDataRangeOptionImplCopyWith<_$WeenatDataRangeOptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
