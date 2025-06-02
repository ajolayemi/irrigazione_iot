// ignore_for_file: public_member_api_docs, sort_constructors_first
/// A representation of keys retrieved from mqtt msg of type pressure
/// It's a msg that holds onto sector pressures, the collector that the sectors
/// belong to and the collector's terminal pressure if available
class KeysFromPressureMsg {
  final String? terminalPressureKey;
  final List<String> collectorPressureKeys;
  final List<String> sectorKeys;
  final List<String> splittedSectorKeys;
  const KeysFromPressureMsg({
    this.terminalPressureKey,
    this.collectorPressureKeys = const [],
    this.sectorKeys = const [],
    this.splittedSectorKeys = const [],
  });
}
