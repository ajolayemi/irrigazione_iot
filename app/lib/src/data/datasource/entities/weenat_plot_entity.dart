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

  WeenatPlotOrgEntity? org;

  int? deviceCount;

  DateTime? lastUpdate;
}

@embedded
@Name('WeenatPlotOrg')
class WeenatPlotOrgEntity {
  int? id;

  String? name;
}