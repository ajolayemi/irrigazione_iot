// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'weenat_plot_entity.g.dart';

/// Isar collection representation of plot data
@collection
@Name('WeenatPlot')
class WeenatPlotEntity {
  late Id? id;

  String? name;

  double? lat;

  double? lng;

  WeenatOrgEntity? org;

  int? deviceCount;

  DateTime? lastUpdate;
}

@embedded
@Name('WeenatOrg')
class WeenatOrgEntity {
  int? id;

  String? name;
}