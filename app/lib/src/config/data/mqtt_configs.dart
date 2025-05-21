import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mqtt_configs.g.dart';

/// Holds the suffixes for the MQTT topics used in the app.
class MqttConfigs {
  /// Suffix for when user is trying to update the pump status.
  String get pumpStatusToggle => 'controlmotor';

  /// Suffix for when user is trying to update sector status
  String get sectorStatusToggle => 'nodered';

  /// Holds onto the list of topics to subscribe to
  List<String> get mqttTopicsToSubscribe => [
        'flutter/prod/collector_pressure',
        'flutter/prod/sector_pressure',
        'flutter/prod/terminal_pressure',
        'flutter/prod/sector_status',
        'flutter/prod/pump_status',
        'flutter/prod/pump_flow',
        'flutter/prod/pump_pressure',
        'flutter/prod/board_status',
      ];
}

@Riverpod(keepAlive: true)
MqttConfigs mqttConfigs(MqttConfigsRef ref) {
  return MqttConfigs();
}
