import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/config/mock/fake_companies_list.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/config/mock/fake_species.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';

final kFakeSectors = kFakeCompanies.expand((company) {
  return List.generate(3, (index) {
    final speciesIndex = index % kFakeSpecies.length;
    final irrigationSystemTypeIndex =
        index % IrrigationSystemType.values.length;
    final irrigationSourceIndex = index % IrrigationSource.values.length;
    final connectedPumps =
        kFakePumps.where((pump) => pump.companyId == company.id).toList();
    final specie = kFakeSpecies[speciesIndex];
    return Sector(
      id: '${index + 1}',
      companyId: company.id,
      name: 'Sector ${company.id}_$index',
      availableSpecie: specie.name,
      specieVariety: specie.variety ?? '',
      area: 100.0 + (index * 10),
      numOfPlants: 10 + (index * 2),
      waterConsumptionPerHourByPlant: 20 + (index * 5),
      totalWaterConsumption: (20 + (index * 5)) * (10 + (index * 2)),
      irrigationSystemType:
          IrrigationSystemType.values[irrigationSystemTypeIndex],
      irrigationSource: IrrigationSource.values[irrigationSourceIndex],
      solenoidValveName: 'solenoid valve ${index + 1}',
      turnOnCommand: '${index + 1}',
      turnOffCommand: '${index + 2}',
      notes: 'extra notes for sector ${company.id}_$index',
      pumpId: connectedPumps.isNotEmpty ? connectedPumps.first.id : null,
    );
  });
}).toList();
