import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/data/datasource/entities/weenat_plot_entity.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalDbInstance {
  Isar? _isar;

  Isar? get isar => _isar;

  Future<void> initLocalDb() async {
    debugPrint('Initializing local database');
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        WeenatPlotEntitySchema,
      ],
      directory: dir.path,
    );
    _isar = isar;
    debugPrint('Local database initialized');
  }
}
