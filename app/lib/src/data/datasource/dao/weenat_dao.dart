
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/data/datasource/dao/app_abstract_dao.dart';
import 'package:irrigazione_iot/src/data/datasource/entities/weenat_plot_entity.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weenat_dao.g.dart';

class WeenatDao extends AppAbstractDao {
  Isar? get _db => dbInstance;

  /// Retrieves available weenat plots from the database
  /// for a given [orgId]
  Future<List<WeenatPlotEntity>?> getWeenatPlotsForOrg(int? orgId) async {
    // TODO: check if there is a better way to filter by orgId
    final allPlots = await _db?.weenatPlotEntitys.where().findAll();
    if (allPlots == null) return null;

    return allPlots.where((plot) => plot.org?.id == orgId).toList();
  }

  /// Retrieves available weenat orgs from the database
  Future<List<WeenatOrgEntity>?> getWeenatOrgs() async {
    final orgs = await _db?.weenatPlotEntitys
        .where(distinct: true)
        .orgProperty()
        .findAll();

    List<WeenatOrgEntity> orgsList = [];

    if (orgs == null) return null;

    for (final org in orgs) {
      final exclude = orgsList.firstWhereOrNull(
            (element) => element.id == org?.id,
          ) !=
          null;
      if (org != null && !exclude) {
        orgsList.add(org);
      }
    }

    return orgsList;
  }

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
WeenatDao weenatDao(WeenatDaoRef ref) {
  return WeenatDao();
}
