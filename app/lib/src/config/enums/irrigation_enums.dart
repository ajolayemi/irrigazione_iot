enum IrrigationSystemType {
  pivot(uiName: 'Pivot'),
  drip(uiName: 'A Goccia'),
  rotolo(uiName: 'Rotolo'),
  subirrigazione(uiName: 'Subirrigazione'),
  sprinkler(uiName: 'Sprinkler');

  const IrrigationSystemType({
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

extension IrrigationSystemTypeX on String {
  IrrigationSystemType toIrrigationSystemType() {
    switch (this) {
      case 'Pivot':
        return IrrigationSystemType.pivot;
      case 'A Goccia':
        return IrrigationSystemType.drip;
      case 'Rotolo':
        return IrrigationSystemType.rotolo;
      case 'Subirrigazione':
        return IrrigationSystemType.subirrigazione;
      case 'Sprinkler':
        return IrrigationSystemType.sprinkler;
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
