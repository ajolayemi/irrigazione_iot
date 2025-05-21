import 'package:json_annotation/json_annotation.dart';

part 'item_status_request.g.dart';

/// A model class of the message sent to the MQTT broker
/// to toggle the status of a pump or sector.
@JsonSerializable()
class ItemStatusRequest {
  const ItemStatusRequest({
    required this.message,
    required this.mqttMsgName,
    required this.messageType,
    required this.companyId,
    required this.itemId,
    required this.statusBoolean,
    this.topic = '',
  });

  /// The topic to publish the message to.
  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  final String topic;

  /// The status code to send to the MQTT broker.
  /// It's usually a numeric value
  @JsonKey(name: "status")
  final String message;

  /// The type of message to send to the MQTT broker.
  /// Example: "pump_status"
  @JsonKey(name: "type")
  final String messageType;

  /// The mqtt alias name of the item to toggle.
  /// Example: "p1" for pump 1
  @JsonKey(name: "name")
  final String mqttMsgName;

  final String itemId;

  final String companyId;

  final bool statusBoolean;

  factory ItemStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$ItemStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ItemStatusRequestToJson(this);
}
