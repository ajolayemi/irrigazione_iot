import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/config/mock/fake_companies_list.dart';
import 'package:irrigazione_iot/src/config/mock/fake_species.dart';
import 'package:irrigazione_iot/src/config/mock/fake_varieties.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';

int id = 0;
int turnOnCommand = 0;
int turnOffCommand = 1;

final kFakeSectors = kFakeCompanies.expand((company) {
  return List.generate(3, (index) {
    int forOn = turnOnCommand + 1;
    turnOnCommand++;
    int forOff = turnOnCommand + 1;
    id++;
    turnOnCommand++;
    final speciesIndex = id % kFakeSpecies.length;
    final varietiesIndex = id % kFakeVarieties.length;
    final irrigationSystemTypeIndex = id % IrrigationSystem.values.length;
    final irrigationSourceIndex = id % IrrigationSource.values.length;
    final specie = kFakeSpecies[speciesIndex];
    final variety = kFakeVarieties[varietiesIndex];
    return Sector(
      id: id.toString(),
      companyId: company.id,
      name: 'Sector ${company.id}_$index',
      specieId: specie.id,
      varietyId: variety.id,
      area: 100.0 + (index * 10),
      numOfPlants: 10 + (index * 2),
      waterConsumptionPerHour: 20 + (index * 5),
      irrigationSystemType: IrrigationSystem.values[irrigationSystemTypeIndex],
      irrigationSource: IrrigationSource.values[irrigationSourceIndex],
      turnOnCommand: forOn.toString(),
      turnOffCommand: forOff.toString(),
      notes: 'extra notes for sector ${company.id}_$index',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      mqttMsgName: 'sector_${company.id}_$index',
      hasFilter: false,
    );
  });
}).toList();
