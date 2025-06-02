import 'package:irrigazione_iot/src/config/data/mqtt_configs.dart';
import 'package:irrigazione_iot/src/config/enums/mqtt_enums.dart';
import 'package:irrigazione_iot/src/utils/app_utils.dart';

/// A local implementation of mqtt topics suffix for testing purposes.
class LocalMqttConfigs implements MqttConfigs {
  @override
  String get pumpStatusToggle => 'cmdebug';

  @override
  String get sectorStatusToggle => 'eldebug';

  @override
  List<String> buildMqttTopicsForSubscription(String companyName) {
    return AppMqttMessageTypes.values.map((item) {
      return AppUtils.buildFullMqttTopic(
        companyName: companyName,
        msgType: item,
      );
    }).toList();
  }
}
