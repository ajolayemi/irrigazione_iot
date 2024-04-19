/// All supported routes in the app
/// By using an enum, we can avoid using strings for route names
/// and the syntax is used
/// ```dart
/// context.goNamed(AppRoute.sampleRoute.name)
/// ```
enum AppRoute {
  home,
  signIn,
  signUp,
  companiesListGrid,
  collector,
  collectorDetails,
  addCollector,
  updateCollector,
  pump,
  pumpDetails,
  addPump,
  updatePump,
  sector,
  sectorDetails,
  addSector,
  updateSector,
  selectASpecie,
  selectAnIrrigationSystem,
  selectAnIrrigationSource,
  connectPumpToSector,
  sectorConnectedPumps,
  connectSectorToCollector,
  more,
  settings,
  boards, // centraline
  boardDetails,
  addBoard,
  updateBoard,
  profile,
  connectCollectorToBoard,
  companyProfile,
  updateCompany,
  companyUsers,
  companyUserDetails,
  addCompanyUser,
  updateCompanyUser,
}