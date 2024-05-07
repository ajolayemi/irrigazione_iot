/// All supported routes in the app
/// By using an enum, we can avoid using strings for route names
/// and the syntax is used
/// ```dart
/// context.goNamed(AppRoute.sampleRoute.name)
/// ```
enum AppRoute {
  home('/'),
  signIn('/sign-in'),
  signUp('/sign-up'),
  companiesListGrid('/companies-list-grid'),
  collector('/collector'),
  collectorDetails('details/:collectorId'),
  addCollector('/add-collector'),
  updateCollector('edit/:collectorId'),
  pump('/pump'),
  pumpDetails('details/:pumpId'),
  addPump('/add-pump'),
  updatePump('edit/:pumpId'),
  sector('/sector'),
  sectorDetails('details/:sectorId'),
  addSector('/add-sector'),
  updateSector('/sector/edit/:sectorId'),
  selectASpecie('/select-a-specie'),
  selectAVariety('/select-a-variety'),
  selectAnIrrigationSystem('/select-an-irrigation-system'),
  selectAnIrrigationSource('/select-an-irrigation-source'),
  connectPumpToSector('/connect-pump-to-sector'),
  connectSectorToCollector('/connect-sectors-to-collector'),
  more('/more'),
  boards('/boards'), // centraline
  boardDetails('details/:boardId'),
  addBoard('/add-board'),
  updateBoard('edit/:boardId'),
  sensors('/sensors'),
  addSensor('/add-sensor'),
  sensorDetails('details/:id'),
  updateSensor('edit/:id'),
  connectSectorToSensor('connect-sector-to-sensor'),
  sensorStatisticHistory('sensor-stat-history'),
  profile('/profile'),
  connectCollectorToBoard('connect-collector-to-board'),
  companyProfile('/company-profile/:companyID'),
  updateCompany('edit'),
  companyUsers('/company-users'),
  companyUserDetails('details/:companyUserId'),
  addCompanyUser('add'),
  updateCompanyUser('edit');

  const AppRoute(this.path);
  final String path;
}
