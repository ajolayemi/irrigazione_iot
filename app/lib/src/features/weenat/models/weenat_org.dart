import 'package:freezed_annotation/freezed_annotation.dart';

part 'weenat_org.freezed.dart';
part 'weenat_org.g.dart';

@freezed
abstract class WeenatOrg with _$WeenatOrg {
  @JsonSerializable(explicitToJson: true)
  const factory WeenatOrg({
    int? id,
    String? name,
  }) = _WeenatOrg;

  factory WeenatOrg.fromJson(Map<String, dynamic> json) =>
      _$WeenatOrgFromJson(json);


}

extension WeenatPlotOrgsX on List<WeenatOrg> {
  List<String> toNames() {
    return map((org) => org.name ?? '').toList();
  }
}

