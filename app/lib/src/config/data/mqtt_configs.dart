import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mqtt_configs.g.dart';

/// Holds the suffixes for the MQTT topics used in the app.
class MqttConfigs {
  /// Suffix for when user is trying to update the pump status.
  String get pumpStatusToggle => 'controlmotor';

  /// Suffix for when user is trying to update sector status
  String get sectorStatusToggle => 'nodered';

  // TODO: [Kehinde] - populate with production topics
  /// Holds onto the list of topics to subscribe to
  List<String> get mqttTopicsToSubscribe => [];
}

@Riverpod(keepAlive: true)
MqttConfigs mqttConfigs(MqttConfigsRef ref) {
  return MqttConfigs();
}
