import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mqtt_topics_suffix.g.dart';


/// Holds the suffixes for the MQTT topics used in the app.
class MqttTopicsSuffix {

  /// Suffix for when user is trying to update the pump status.
  String get pumpStatusToggle => 'controlmotor'; 

  /// Suffix for when user is trying to update sector status
  String get sectorStatusToggle => 'nodered';
}

@Riverpod(keepAlive: true)
MqttTopicsSuffix mqttTopicsSuffix(MqttTopicsSuffixRef ref) {
  return MqttTopicsSuffix();
}
