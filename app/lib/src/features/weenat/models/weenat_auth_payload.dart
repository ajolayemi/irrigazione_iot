import 'package:freezed_annotation/freezed_annotation.dart';

part 'weenat_auth_payload.freezed.dart';
part 'weenat_auth_payload.g.dart';

@freezed
class WeenatAuthPayload with _$WeenatAuthPayload {
  const WeenatAuthPayload._();

  const factory WeenatAuthPayload({
    String? email,
    String? password,
  }) = _WeenatAuthPayload;

  factory WeenatAuthPayload.fromJson(Map<String, dynamic> json) =>
      _$WeenatAuthPayloadFromJson(json);
}
