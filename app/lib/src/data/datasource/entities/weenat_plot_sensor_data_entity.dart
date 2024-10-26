import 'package:irrigazione_iot/src/config/enums/weenat_sensor_data_types.dart';
import 'package:isar/isar.dart';

part 'weenat_plot_sensor_data_entity.g.dart';

@collection
@Name('WeenatPlotSensorData')
class WeenatPlotSensorDataEntity {
  late Id? id;

  /// The related sensor data, which could be soil temperature
  /// or water potential at different depths
  double? sensorData;

  /// The depth at which the sensor data is associated with
  double? sensorDataDepth;

  /// The type of sensor data
  @Enumerated(EnumType.name)
  WeenatSensorDataType? dataType;

  /// The timestamp of when this data was registered
  DateTime? timeStamp;

  /// The id of the plot to which this data belongs to
  int? plotId;
}
