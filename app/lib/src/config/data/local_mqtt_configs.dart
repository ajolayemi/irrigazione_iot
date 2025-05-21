import 'package:irrigazione_iot/src/config/data/mqtt_configs.dart';

/// A local implementation of mqtt topics suffix for testing purposes.
class LocalMqttConfigs implements MqttConfigs {
  @override
  String get pumpStatusToggle => 'cmdebug';

  @override
  String get sectorStatusToggle => 'eldebug';

  @override
  List<String> get mqttTopicsToSubscribe {
    return [
      'flutter/dev/collector_pressure',
      'flutter/dev/sector_pressure',
      'flutter/dev/terminal_pressure',
      'flutter/dev/sector_status',
      'flutter/dev/pump_status',
      'flutter/dev/pump_flow',
      'flutter/dev/pump_pressure',
      'flutter/dev/board_status'
    ];
  }
}
