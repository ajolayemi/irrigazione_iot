import 'package:irrigazione_iot/src/config/enums/mqtt_enums.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';

class AppUtils {
  const AppUtils._();

  /// Builder to build a full mqtt topic for subscription
  /// and also to use when posting messages like pump_status
  /// specific to a particular company
  static String buildFullMqttTopic({
    required String companyName,
    required AppMqttMessageTypes msgType,
  }) {
    const env = String.fromEnvironment(AppConstants.appEnvType);
    return '$companyName/flutter/$env/${msgType.type}';
  }
}
