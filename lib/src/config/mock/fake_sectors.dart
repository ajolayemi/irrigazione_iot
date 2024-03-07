import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/config/mock/fake_companies_list.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/config/mock/fake_species.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';

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
    final irrigationSystemTypeIndex = id % IrrigationSystemType.values.length;
    final irrigationSourceIndex = id % IrrigationSource.values.length;
    final connectedPumps =
        kFakePumps.where((pump) => pump.companyId == company.id).toList();
    final specie = kFakeSpecies[speciesIndex];
    return Sector(
      id: id.toString(),
      companyId: company.id,
      name: 'Sector ${company.id}_$index',
      availableSpecie: specie.name,
      specieVariety: specie.variety ?? '',
      area: 100.0 + (index * 10),
      numOfPlants: 10 + (index * 2),
      waterConsumptionPerHourByPlant: 20 + (index * 5),
      irrigationSystemType:
          IrrigationSystemType.values[irrigationSystemTypeIndex],
      irrigationSource: IrrigationSource.values[irrigationSourceIndex],
      turnOnCommand: forOn.toString(),
      turnOffCommand: forOff.toString(),
      notes: 'extra notes for sector ${company.id}_$index',
      pumpId: connectedPumps.isNotEmpty ? connectedPumps.first.id : null,
    );
  });
}).toList();
