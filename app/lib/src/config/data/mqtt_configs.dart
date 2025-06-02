import 'package:irrigazione_iot/src/config/enums/mqtt_enums.dart';
import 'package:irrigazione_iot/src/utils/app_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mqtt_configs.g.dart';

/// Holds the suffixes for the MQTT topics used in the app.
class MqttConfigs {
  /// Suffix for when user is trying to update the pump status.
  String get pumpStatusToggle => 'controlmotor';

  /// Suffix for when user is trying to update sector status
  String get sectorStatusToggle => 'nodered';

  /// Holds onto the list of topics to subscribe to
  List<String> buildMqttTopicsForSubscription(String companyName) {
    return AppMqttMessageTypes.values.map((item) {
      return AppUtils.buildFullMqttTopic(
        companyName: companyName,
        msgType: item,
      );
    }).toList();
  }
}

@Riverpod(keepAlive: true)
MqttConfigs mqttConfigs(MqttConfigsRef ref) {
  return MqttConfigs();
}
