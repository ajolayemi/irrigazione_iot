import 'package:irrigazione_iot/src/config/data/mqtt_topics_suffix.dart';

/// A local implementation of mqtt topics suffix for testing purposes.
class LocalMqttTopicsSuffix implements MqttTopicsSuffix {
  @override
  String get pumpStatusToggle => 'cmdebug';

  @override
  String get sectorStatusToggle => 'eldebug';
}