import 'package:freezed_annotation/freezed_annotation.dart';

part 'weenat_auth_res_data.freezed.dart';
part 'weenat_auth_res_data.g.dart';

@freezed
class WeenatAuthResData with _$WeenatAuthResData {
  const WeenatAuthResData._();

  const factory WeenatAuthResData({
    String? token,
  }) = _WeenatAuthResData;

  factory WeenatAuthResData.fromJson(Map<String, dynamic> json) =>
      _$WeenatAuthResDataFromJson(json);
}
