import 'package:json_annotation/json_annotation.dart';

part 'firebase_callable_function_body.g.dart';

@JsonSerializable()
class FirebaseCallableFunctionBody {
  const FirebaseCallableFunctionBody({
    required this.topic,
    required this.message,
    required this.mqttMsgName,
    required this.msgBoolVersion,
    this.isSector,
    this.isPump,
  });

  final String topic;
  final String message;
  final bool msgBoolVersion;
  final String mqttMsgName;
  final bool? isSector;
  final bool? isPump;

  factory FirebaseCallableFunctionBody.fromJson(Map<String, dynamic> json) =>
      _$FirebaseCallableFunctionBodyFromJson(json);
  Map<String, dynamic> toJson() => _$FirebaseCallableFunctionBodyToJson(this);
}
