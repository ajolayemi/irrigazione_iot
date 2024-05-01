import 'package:json_annotation/json_annotation.dart';

part 'rpc_parameter.g.dart';

/// The query parameter passed when calling a
/// rpc method, i.e Supabase database function.
@JsonSerializable()
class RpcParameters {
  const RpcParameters({
    required this.companyId,
    this.idAlreadyConnected,
  });

  @JsonKey(name: 'company_id_input')
  final String companyId;
  @JsonKey(name: 'id_already_connected')
  final String? idAlreadyConnected;

  factory RpcParameters.fromJson(Map<String, dynamic> json) =>
      _$RpcParametersFromJson(json);

  Map<String, dynamic> toJson() => _$RpcParametersToJson(this);
}
