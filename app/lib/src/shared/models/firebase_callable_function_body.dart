import 'package:json_annotation/json_annotation.dart';

part 'firebase_callable_function_body.g.dart';

@JsonSerializable()
class FirebaseCallableFunctionBody {
  const FirebaseCallableFunctionBody({
    required this.topic,
    required this.message,
    required this.mqttMsgName,
  });

  final String topic;
  final String message;
  final String mqttMsgName;

  factory FirebaseCallableFunctionBody.fromJson(Map<String, dynamic> json) =>
      _$FirebaseCallableFunctionBodyFromJson(json);
  Map<String, dynamic> toJson() => _$FirebaseCallableFunctionBodyToJson(this);
}
