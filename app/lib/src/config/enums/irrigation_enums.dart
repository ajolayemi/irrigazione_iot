enum IrrigationSystem {
  pivot(uiName: 'Pivot'),
  drip(uiName: 'A Goccia'),
  rotolo(uiName: 'Rotolo'),
  subirrigazione(uiName: 'Subirrigazione'),
  sprinkler(uiName: 'Sprinkler'),
  other(uiName: 'Altro');

  const IrrigationSystem({
    required this.uiName,
  });

  // the name to display in the UI, mostly in forms
  final String uiName;
}

enum IrrigationSource {
  well(uiName: 'Pozzo'),
  cistern(uiName: 'Cisterna'),
  river(uiName: 'Fiume'),
  lake(uiName: 'Lago'),
  canal(uiName: 'Canale'),
  invaso(uiName: 'Invaso'),
  consortium(uiName: 'Consorzio di Bonifica'),
  other(uiName: 'Altro');

  const IrrigationSource({
    required this.uiName,
  });

  // the name to display in the UI, mostly in forms
  final String uiName;
}

extension IrrigationSystemType on String {
  IrrigationSystem toIrrigationSystemType() {
    switch (this) {
      case 'Pivot':
        return IrrigationSystem.pivot;
      case 'A Goccia':
        return IrrigationSystem.drip;
      case 'Rotolo':
        return IrrigationSystem.rotolo;
      case 'Subirrigazione':
        return IrrigationSystem.subirrigazione;
      case 'Sprinkler':
        return IrrigationSystem.sprinkler;
      default:
        throw ArgumentError('Invalid irrigation system type: $this');
    }
  }
}

extension IrrigationSourceX on String {
  IrrigationSource toIrrigationSource() {
    switch (this) {
      case 'Pozzo':
        return IrrigationSource.well;
      case 'Cisterna':
        return IrrigationSource.cistern;
      case 'Fiume':
        return IrrigationSource.river;
      case 'Lago':
        return IrrigationSource.lake;
      case 'Canale':
        return IrrigationSource.canal;
      case 'Invaso':
        return IrrigationSource.invaso;
      case 'Consorzio di Bonifica':
        return IrrigationSource.consortium;
      case 'Altro':
        return IrrigationSource.other;
      default:
        throw ArgumentError('Invalid irrigation source: $this');
    }
  }
}
