import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/data/datasource/dao/app_abstract_dao.dart';
import 'package:irrigazione_iot/src/data/datasource/entities/weenat_plot_entity.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weenat_dao.g.dart';

class WeenatDao extends AppAbstractDao {
  Isar? get _db => dbInstance;

  /// Inserts a list of weenat plots into the database
  Future<void> insertWeenatPlots({
    required List<WeenatPlotEntity> plots,
  }) async {
    if (plots.isEmpty) return;
    debugPrint('Inserting ${plots.length} plots into database');
    final inserted = await _db?.writeTxn(
      () async => await _db?.weenatPlotEntitys.putAll(plots),
    );
    debugPrint('Inserted ${inserted?.length ?? 0} plots into database');
  }
}

@Riverpod(keepAlive: true)
WeenatDao  weenatDao(WeenatDaoRef ref) {
  return WeenatDao();
}
