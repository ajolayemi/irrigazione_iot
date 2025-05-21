import 'package:irrigazione_iot/src/config/data/mqtt_configs.dart';

/// A local implementation of mqtt topics suffix for testing purposes.
class LocalMqttConfigs implements MqttConfigs {
  @override
  String get pumpStatusToggle => 'cmdebug';

  @override
  String get sectorStatusToggle => 'eldebug';

  @override
  List<String> get mqttTopicsToSubscribe {
    return ['valenziani/test_mqtt_flutter'];
  }
}
