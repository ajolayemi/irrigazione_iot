// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weenat_auth_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeenatAuthPayload _$WeenatAuthPayloadFromJson(Map<String, dynamic> json) {
  return _WeenatAuthPayload.fromJson(json);
}

/// @nodoc
mixin _$WeenatAuthPayload {
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeenatAuthPayloadCopyWith<WeenatAuthPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeenatAuthPayloadCopyWith<$Res> {
  factory $WeenatAuthPayloadCopyWith(
          WeenatAuthPayload value, $Res Function(WeenatAuthPayload) then) =
      _$WeenatAuthPayloadCopyWithImpl<$Res, WeenatAuthPayload>;
  @useResult
  $Res call({String? email, String? password});
}

/// @nodoc
class _$WeenatAuthPayloadCopyWithImpl<$Res, $Val extends WeenatAuthPayload>
    implements $WeenatAuthPayloadCopyWith<$Res> {
  _$WeenatAuthPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeenatAuthPayloadImplCopyWith<$Res>
    implements $WeenatAuthPayloadCopyWith<$Res> {
  factory _$$WeenatAuthPayloadImplCopyWith(_$WeenatAuthPayloadImpl value,
          $Res Function(_$WeenatAuthPayloadImpl) then) =
      __$$WeenatAuthPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? email, String? password});
}

/// @nodoc
class __$$WeenatAuthPayloadImplCopyWithImpl<$Res>
    extends _$WeenatAuthPayloadCopyWithImpl<$Res, _$WeenatAuthPayloadImpl>
    implements _$$WeenatAuthPayloadImplCopyWith<$Res> {
  __$$WeenatAuthPayloadImplCopyWithImpl(_$WeenatAuthPayloadImpl _value,
      $Res Function(_$WeenatAuthPayloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_$WeenatAuthPayloadImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeenatAuthPayloadImpl extends _WeenatAuthPayload {
  const _$WeenatAuthPayloadImpl({this.email, this.password}) : super._();

  factory _$WeenatAuthPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeenatAuthPayloadImplFromJson(json);

  @override
  final String? email;
  @override
  final String? password;

  @override
  String toString() {
    return 'WeenatAuthPayload(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeenatAuthPayloadImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeenatAuthPayloadImplCopyWith<_$WeenatAuthPayloadImpl> get copyWith =>
      __$$WeenatAuthPayloadImplCopyWithImpl<_$WeenatAuthPayloadImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeenatAuthPayloadImplToJson(
      this,
    );
  }
}

abstract class _WeenatAuthPayload extends WeenatAuthPayload {
  const factory _WeenatAuthPayload(
      {final String? email, final String? password}) = _$WeenatAuthPayloadImpl;
  const _WeenatAuthPayload._() : super._();

  factory _WeenatAuthPayload.fromJson(Map<String, dynamic> json) =
      _$WeenatAuthPayloadImpl.fromJson;

  @override
  String? get email;
  @override
  String? get password;
  @override
  @JsonKey(ignore: true)
  _$$WeenatAuthPayloadImplCopyWith<_$WeenatAuthPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
