/// All supported routes in the app
/// By using an enum, we can avoid using strings for route names
/// and the syntax is used
/// ```dart
/// context.goNamed(AppRoute.sampleRoute.name)
/// ```
enum AppRoute {
  welcome('/welcome'),
  registerCompany('/register-company'),
  home('/'),
  signIn('/sign-in'),
  signUp('/sign-up'),
  companiesListGrid('/companies-list-grid'),
  collector('/collector'),
  collectorDetails('details/:id'),
  addCollector('/add-collector'),
  updateCollector('/collector/edit/:id'),
  pump('/pump'),
  pumpDetails('details/:id'),
  addPump('/add-pump'),
  updatePump('/pump/edit/:id'),
  sector('/sector'),
  sectorDetails('details/:id'),
  addSector('/add-sector'),
  updateSector('/sector/edit/:id'),
  selectASpecie('/select-a-specie'),
  selectAVariety('/select-a-variety'),
  selectAnIrrigationSystem('/select-an-irrigation-system'),
  selectAnIrrigationSource('/select-an-irrigation-source'),
  connectPumpToSector('/connect-pump-to-sector'),
  connectSectorToCollector('/connect-sectors-to-collector'),
  more('/more'),
  boards('/boards'), // centraline
  boardDetails('details/:id'),
  addBoard('add-board'),
  updateBoard('edit/:id'),
  weatherStations('/weatherStations'),
  addWeatherStation('add-weather-station'),
  weatherStationDetails('details/:id'),
  updateWeatherStation('edit/:id'),
  connectSectorToWeatherStation('connect-sector-to-weather-station'),
  weatherStationStatisticHistory('weather-station-stat-history'),
  profile('/profile'),
  connectCollectorToBoard('connect-collector-to-board'),
  companyProfile('/company-profile/:id'),
  updateCompany('edit'),
  companyUsers('/company-users'),
  companyUserDetails('details/:id'),
  addCompanyUser('add'),
  updateCompanyUser('edit');

  const AppRoute(this.path);
  final String path;
}
