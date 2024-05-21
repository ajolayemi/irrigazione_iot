import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'irrigazione_iot';

  @override
  String get homePageTitle => 'Home';

  @override
  String get emailFormFieldTitle => 'Email';

  @override
  String get passwordFormFieldTitle => 'Password';

  @override
  String get signInButtonTitle => 'Sign In';

  @override
  String get emailFormHint => 'example@example.com';

  @override
  String get passwordFormHint => '••••••••';

  @override
  String get signInWithGoogleButtonTitle => 'Google';

  @override
  String get forgotPasswordButtonTitle => 'Forgot Password?';

  @override
  String get orSignWithText => 'or sign in with';

  @override
  String get invalidEmailErrorText => 'Invalid email';

  @override
  String get emptyEmailErrorText => 'Email can\'t be empty';

  @override
  String shortPasswordErrorText(int minPasswordLength) {
    return 'Password is too short, it has to be a minimum of $minPasswordLength characters';
  }

  @override
  String get emptyPasswordErrorText => 'Password can\'t be empty';

  @override
  String get settingsPageTitle => 'Settings';

  @override
  String get collectorPageTitle => 'Collectors';

  @override
  String get pumpPageTitle => 'Pumps';

  @override
  String get meteoPageTitle => 'Meteo';

  @override
  String get sectorPageTitle => 'Sectors';

  @override
  String get graphsPageTitle => 'Graphs';

  @override
  String get morePageTitle => 'More';

  @override
  String get chooseCompany => 'Choose a company';

  @override
  String welcome(Object username) {
    return 'Welcome, $username!';
  }

  @override
  String get alertDialogCancel => 'Cancel';

  @override
  String get alertDialogConfirm => 'Confirm';

  @override
  String get alertDialogDelete => 'Delete';

  @override
  String get genericAlertDialogTitle => 'Are you sure?';

  @override
  String pumpFlowLastUpdate(String when) {
    return 'last update $when';
  }

  @override
  String get genericSaveButtonLabel => 'Save';

  @override
  String get genericUpdateButtonLabel => 'Update';

  @override
  String onStatusUpdateAlertDialogContent(Object name) {
    return 'You\'re about to switch on $name';
  }

  @override
  String offStatusUpdateAlertDialogContent(Object name) {
    return 'You\'re about to switch off $name';
  }

  @override
  String get onStatusDialogConfirmButtonTitle => 'Switch On';

  @override
  String get offStatusDialogConfirmButtonTitle => 'Switch Off';

  @override
  String get statusListTileTitle => 'Current Status';

  @override
  String get onStatusValue => 'On';

  @override
  String get offStatusValue => 'Off';

  @override
  String noCompanyFoundForUser(Object username) {
    return 'Hello $username!\nThere is no company associated with your account in our database';
  }

  @override
  String get logInWithAnotherAccount => 'Change Account';

  @override
  String get addNewPumpPageTitle => 'New Pump';

  @override
  String get updatePumpPageTitle => 'Update Pump';

  @override
  String get pumpNameFormHint => 'eg: Pompa Giardino';

  @override
  String get pumpVolumeCapacityFormFieldTitle => 'Volume capacity';

  @override
  String get pumpVolumeCapacityFormHint => 'eg: 1000';

  @override
  String get pumpKwFormFieldTitle => 'Power (kW)';

  @override
  String get pumpKwFormHint => 'eg: 50';

  @override
  String get onCommandFormFieldTitle => 'On command';

  @override
  String get onCommandFormHint => 'eg: 1';

  @override
  String get offCommandFormFieldTitle => 'Off command';

  @override
  String get offCommandFormHint => 'eg: 2';

  @override
  String get formGenericSaveDialogTitle => 'Do you want to save the data?';

  @override
  String formGenericSaveDialogContent(Object fieldName) {
    return 'You\'re about to save the data for $fieldName in the database';
  }

  @override
  String get formGenericUpdateDialogTitle => 'Do you want to update the data?';

  @override
  String formGenericUpdateDialogContent(Object fieldName) {
    return 'You\'re about to update the data for $fieldName in the database';
  }

  @override
  String get notAvailable => 'Not available';

  @override
  String deleteConfirmationDialogTitle(Object name) {
    return 'Clicking on delete will remove all data related to $name from database';
  }

  @override
  String sectorLastIrrigation(String when) {
    return 'last irrigation $when';
  }

  @override
  String get sectorNameHintText => 'eg: ME8';

  @override
  String get sectorSpecie => 'Specie';

  @override
  String get sectorSpecieHintText => 'select a specie...';

  @override
  String get sectorVariety => 'Variety';

  @override
  String get sectorVarietyHintText => 'select a variety...';

  @override
  String get sectorOccupiedArea => 'Occupied area';

  @override
  String get sectorOccupiedAreaHintText => 'eg: 100';

  @override
  String get sectorNumberOfPlants => 'Number of plants';

  @override
  String get sectorNumberOfPlantsHintText => 'eg: 100';

  @override
  String get sectorUnitConsumptionPerHour => 'Consumption per plant (l/h)';

  @override
  String get sectorUnitConsumptionPerHourHintText => 'eg: 1';

  @override
  String get sectorTotalConsumption => 'Total consumption (l/h)';

  @override
  String get sectorIrrigationSystem => 'Irrigation system';

  @override
  String get sectorIrrigationSource => 'Irrigation source';

  @override
  String get sectorNotes => 'Notes';

  @override
  String get sectorConnectedPumps => 'Connected pump';

  @override
  String get sectorLastIrrigationEmpty => 'Never irrigated';

  @override
  String get sectorLastIrrigationForTile => 'Last irrigated';

  @override
  String get addSectorPageTitle => 'New Sector';

  @override
  String get updateSectorPageTitle => 'Update Sector';

  @override
  String get selectASpecie => 'Select a specie';

  @override
  String get selectAnOption => 'Select an option';

  @override
  String fieldTooLongErrorText(int max) {
    return 'Field value is too long, it has to be a maximum of $max characters';
  }

  @override
  String get emptyFormFieldErrorText => 'Field can\'t be empty';

  @override
  String get notANumberErrorText => 'Field has to be a number';

  @override
  String get notGreaterThanZeroErrorText => 'Field has to be greater than 0';

  @override
  String commandAlreadyInUseErrorText(Object fieldName) {
    return 'This command value is already in use for another $fieldName';
  }

  @override
  String duplicateCommandsInFormErrorText(String fieldName) {
    return 'You can\'t use the same command to switch on and switch off $fieldName';
  }

  @override
  String fieldValueAlreadyInUseErrorText(String fieldName) {
    return 'This value is already in use for another $fieldName';
  }

  @override
  String nPumps(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'pumps',
      two: 'pumps',
      one: 'pump',
    );
    return '$_temp0';
  }

  @override
  String nPumpsWithIndefiniteArticle(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'pumps',
      two: 'pumps',
      one: 'a pump',
    );
    return '$_temp0';
  }

  @override
  String nPumpsWithDefiniteArticle(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'pumps',
      two: 'pumps',
      one: 'the pump',
    );
    return '$_temp0';
  }

  @override
  String nPumpsWithArticulatedPreposition(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'the pumps',
      two: 'the pumps',
      one: 'the pump',
    );
    return '$_temp0';
  }

  @override
  String nSectors(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'sectors',
      two: 'sectors',
      one: 'sector',
    );
    return '$_temp0';
  }

  @override
  String nSectorsWithIndefiniteArticle(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'sectors',
      two: 'sectors',
      one: 'a sector',
    );
    return '$_temp0';
  }

  @override
  String nSectorsWithDefiniteArticle(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'sectors',
      two: 'sectors',
      one: 'the sector',
    );
    return '$_temp0';
  }

  @override
  String nSectorsWithArticulatedPreposition(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'the sectors',
      two: 'the sectors',
      one: 'the sector',
    );
    return '$_temp0';
  }

  @override
  String emptyDataPlaceholder(Object name) {
    return 'No $name was found in the database';
  }

  @override
  String get addNewButtonLabel => 'Add New';

  @override
  String get connectPumpToSectorPageTile => 'Select a pump';

  @override
  String get noPumpConnectedToSectorErrorText => 'You have to connect at least one pump to this sector';

  @override
  String get pumpLastDispensationForTile => 'Was last switched on';

  @override
  String get pumpLastDispensationEmpty => 'Never switched on';

  @override
  String get pumpTotalDispensedLitres => 'Total litres dispensed';

  @override
  String nCollectors(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'collectors',
      two: 'collectors',
      one: 'collector',
    );
    return '$_temp0';
  }

  @override
  String nCollectorsWithIndefiniteArticle(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'collectors',
      two: 'collectors',
      one: 'a collector',
    );
    return '$_temp0';
  }

  @override
  String nCollectorsWithDefiniteArticle(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'collectors',
      two: 'collectors',
      one: 'the collector',
    );
    return '$_temp0';
  }

  @override
  String nCollectorsWithArticulatedPreposition(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'the collectors',
      two: 'the collectors',
      one: 'the collector',
    );
    return '$_temp0';
  }

  @override
  String get addNewCollectorPageTitle => 'New Collector';

  @override
  String get updateCollectorPageTitle => 'Update Collector';

  @override
  String get collectorName => 'Collector name';

  @override
  String get collectorNameHintText => 'eg: Collettore Giardino';

  @override
  String get collectorFilterName => 'Filter (filtro) name ';

  @override
  String get collectorFilterNameHintText => 'eg: Filtro 1';

  @override
  String nSelectedSectors(num n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sectors selected',
      one: '1 sector selected',
      zero: '0 sectors selected',
    );
    return '$_temp0';
  }

  @override
  String get connectSectorToCollectorPageTitle => 'Select Sectors';

  @override
  String get collectorConnectedSectors => 'Connected sectors';

  @override
  String get noSectorConnectedToCollectorErrorText => 'You have to connect at least one sector to this collector';

  @override
  String get genericConfirmButtonLabel => 'Confirm';

  @override
  String get allSectorsAreConnectedToACollector => 'All available sectors have already been connected to a collector';

  @override
  String nConnectedSectors(num n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sectors connected',
      one: '1 sector connected',
      zero: '0 sectors connected',
    );
    return '$_temp0';
  }

  @override
  String get batteryLevel => 'Battery:';

  @override
  String get filterPressureDifference => 'Filter diff:';

  @override
  String get iotBoardsMenuTitle => 'Boards';

  @override
  String get settingsMenuTitle => 'Settings';

  @override
  String get profilePageTitle => 'My Profile';

  @override
  String get logOutButtonTitle => 'Logout';

  @override
  String get logOutAlertDialogTitle => 'Are you sure you want to log out?';

  @override
  String get logOutAlertDialogContent => 'You will be logged out of the application';

  @override
  String get logOutAlertDialogConfirm => 'Logout';

  @override
  String nBoards(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'boards',
      two: 'boards',
      one: 'board',
    );
    return '$_temp0';
  }

  @override
  String nBoardsWithIndefiniteArticle(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'boards',
      two: 'boards',
      one: 'a board',
    );
    return '$_temp0';
  }

  @override
  String nBoardsWithDefiniteArticle(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'boards',
      two: 'boards',
      one: 'the board',
    );
    return '$_temp0';
  }

  @override
  String nBoardsWithArticulatedPreposition(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'the boards',
      two: 'the boards',
      one: 'the board',
    );
    return '$_temp0';
  }

  @override
  String get addNewBoardPageTitle => 'New Board';

  @override
  String get updateBoardPageTitle => 'Update Board';

  @override
  String get boardNameHintText => 'eg: arduino mkr16';

  @override
  String get boardModel => 'Model';

  @override
  String get boardModelHintText => 'eg: MKR 1010';

  @override
  String get boardSerialNumber => 'Serial number';

  @override
  String get boardSerialNumberHintText => 'eg: 123456789';

  @override
  String get boardConnectedCollector => 'Connected Collector';

  @override
  String get boardConnectedCollectorHintText => 'Select a collector';

  @override
  String get allCollectorsAreConnectedToABoard => 'All available collectors have already been connected to a board';

  @override
  String get connectCollectorToBoardPageTitle => 'Select a collector';

  @override
  String nSelectedCollectors(num n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n collectors selected',
      one: '1 collector selected',
      zero: '0 collectors selected',
    );
    return '$_temp0';
  }

  @override
  String get noCollectorConnectedToBoardErrorText => 'You have to connect at least one collector to this board';

  @override
  String get userProfileDetailsName => 'Names';

  @override
  String get userProfileDetailsEmail => 'Email';

  @override
  String get userProfileDetailsCurrentCompany => 'Current company profile';

  @override
  String get companyProfileMenuTitle => 'Company Profile';

  @override
  String get companyUsersMenuTitle => 'My Company Users';

  @override
  String get companyNameHintText => 'eg: My Company';

  @override
  String get companyRegisteredAddress => 'Registered office address';

  @override
  String get companyRegisteredAddressHintText => 'eg: 123 Main Street, 12345, City, Country';

  @override
  String get companyVatNumber => 'VAT number';

  @override
  String get companyVatNumberHintText => 'eg: 123456789';

  @override
  String get companyFiscalCode => 'Fiscal code';

  @override
  String get companyFiscalCodeHintText => 'eg: 123456789';

  @override
  String get companyEmail => 'Email';

  @override
  String get companyEmailHintText => 'eg: email@company.com';

  @override
  String get companyPhone => 'Phone';

  @override
  String get companyPhoneHintText => 'eg: +123456789';

  @override
  String dependentFieldsEmptyErrorText(Object firstFieldName, Object secondFieldName) {
    return 'One between $firstFieldName and $secondFieldName has to be filled';
  }

  @override
  String get addNewCompanyPageTitle => 'New Company';

  @override
  String get updateCompanyPageTitle => 'Update Company';

  @override
  String nCompany(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'companies',
      two: 'companies',
      one: 'company',
    );
    return '$_temp0';
  }

  @override
  String get noUsersConnectedWithCompany => 'You have no registered users associated with your company';

  @override
  String get companyUserFullName => 'Full name';

  @override
  String get companyUserFullNameHintTest => 'eg: John Doe';

  @override
  String get companyUserEmail => 'Email';

  @override
  String get companyUserEmailHintText => 'eg: example@example.com';

  @override
  String get companyUserRole => 'Assign a role';

  @override
  String get companyUserRoleHintText => 'Select a role';

  @override
  String get companyUserAssignedRoleForDetails => 'Assigned role';

  @override
  String get companyUserAddedOn => 'Added on';

  @override
  String get companyUserLastUpdated => 'Last updated';

  @override
  String get addNewCompanyUserPageTitle => 'New User';

  @override
  String get updateCompanyUserPageTitle => 'Update User';

  @override
  String get emailAlreadyInUseErrorText => 'This email is already in use';

  @override
  String nCompanyUsers(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'company users',
      two: 'company users',
      one: 'company user',
    );
    return '$_temp0';
  }

  @override
  String get assignRoleDialogTitle => 'Assign a role';

  @override
  String get me => 'Me';

  @override
  String get companyUserDismissalDialogTitle => 'Are you sure you want to delete this user?';

  @override
  String companyUserDismissalDialogContent(Object companyUserName) {
    return 'You\'re about to delete $companyUserName as a user';
  }

  @override
  String get cantDeleteYourselfDialogTitle => 'You can\'t delete yourself as a user';

  @override
  String get noUppercaseInPasswordErrorText => 'Password has to contain at least one uppercase letter';

  @override
  String get noLowercaseInPasswordErrorText => 'Password has to contain at least one lowercase letter';

  @override
  String get noNumberInPasswordErrorText => 'Password has to contain at least one number';

  @override
  String get noSpecialCharacterInPasswordErrorText => 'Password has to contain at least one special character';

  @override
  String get passwordsDoNotMatchErrorText => 'Passwords do not match';

  @override
  String get invalidCredentialsErrorText => 'The email or password you entered is incorrect';

  @override
  String get introductorySignInText => 'Sign in with your registered account details to continue';

  @override
  String get noAccountText => 'Don\'t have an account?';

  @override
  String get signUpText => 'Sign Up';

  @override
  String get signUpButtonTitle => 'Sign Up';

  @override
  String get confirmPasswordFormFieldTitle => 'Confirm password';

  @override
  String get confirmPasswordFormHint => '••••••••';

  @override
  String get alreadyHaveAnAccountText => 'Already have an account?';

  @override
  String get nameFormFieldTitle => 'Name';

  @override
  String get nameFormHint => 'John';

  @override
  String get surnameFormFieldTitle => 'Surname';

  @override
  String get surnameFormHint => 'Doe';

  @override
  String get signInPageIntroductoryTitleText => 'Welcome back!';

  @override
  String get signUpPageIntroductoryTitleText => 'Get started with us!';

  @override
  String get signUpPageIntroductorySubtitleText => 'Create your account';

  @override
  String get signInPageIntroductorySubtitleText => 'Sign into your account to continue';

  @override
  String get mqttMessageNameFormFieldTitle => 'Code name in MQTT message';

  @override
  String get mqttMessageNameFormHint => 'alias name in mqtt msgs...';

  @override
  String get itemHasFilter => 'Has a filter connected?';

  @override
  String get selectAPumpHintText => 'select a pump...';

  @override
  String get selectAVarietyPageTitle => 'Select a variety';

  @override
  String get selectAnOptionHintText => 'select an option...';

  @override
  String get mqttTopicNameFormFieldTitle => 'Name in MQTT topic';

  @override
  String get mqttTopicNameFormHint => 'alias name in mqtt topic...';

  @override
  String get switchOn => 'Switch On';

  @override
  String get switchOff => 'Switch Off';

  @override
  String get entityCharacteristics => 'Characteristics';

  @override
  String get entityStatistics => 'Statistics';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get mqttOnCommand => 'On Command (MQTT)';

  @override
  String get mqttOffCommand => 'Off Command (MQTT)';

  @override
  String get lastFilterInPressure => 'Last filter in pressure';

  @override
  String get lastFilterOutPressure => 'Last filter out pressure';

  @override
  String get lastFilterPressureDifference => 'Last filter pressure difference';

  @override
  String get pressure => 'Pressure';

  @override
  String get sensorPageTitle => 'Sensors';

  @override
  String nSensors(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'sensors',
      two: 'sensors',
      one: 'sensor',
    );
    return '$_temp0';
  }

  @override
  String nSensorsWithIndefiniteArticle(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'sensors',
      two: 'sensors',
      one: 'a sensor',
    );
    return '$_temp0';
  }

  @override
  String nSensorsWithDefiniteArticle(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'sensors',
      two: 'sensors',
      one: 'the sensor',
    );
    return '$_temp0';
  }

  @override
  String nSensorsWithArticulatedPreposition(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'the sensors',
      two: 'the sensors',
      one: 'the sensor',
    );
    return '$_temp0';
  }

  @override
  String get addSensorPageTitle => 'New Sensor';

  @override
  String get updateSensorPageTitle => 'Update Sensor';

  @override
  String get airTemperature => 'Air Temperature';

  @override
  String get airHumidity => 'Air Humidity';

  @override
  String get lightIntensity => 'Light Intensity';

  @override
  String get barometricPressure => 'Barometric Pressure';

  @override
  String get windDirection => 'Wind Direction';

  @override
  String get windSpeed => 'Wind Speed';

  @override
  String get rainfallHourly => 'Rainfall Hourly';

  @override
  String get uvIndex => 'UV Index';

  @override
  String get deviceEui => 'Device EUI';

  @override
  String get sensorsMenuTitle => 'Sensors';

  @override
  String get lastUpdated => 'Last updated';

  @override
  String get connectedSector => 'Connected sector';

  @override
  String get weatherStationNameHintText => 'eg: Stazione meteo 1';

  @override
  String get weatherStationEuiHintText => 'device unique identifier...';

  @override
  String get selectASectorPageTitle => 'Select a sector';

  @override
  String get historyPageTitle => 'History';

  @override
  String get noHistory => 'No history';

  @override
  String get registerYourCompany => 'Register your company';

  @override
  String get loginToYourAccount => 'Login to your account';

  @override
  String get welcomePageIntro => 'We\'re glad to have you here! Please select an option to continue';

  @override
  String get or => 'or';

  @override
  String get companyCreatedSuccessfully => 'Your company has been created successfully!';

  @override
  String get weatherStationPageTitle => 'Weather Stations';

  @override
  String nWeatherStations(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'weather stations',
      two: 'weather stations',
      one: 'weather station',
    );
    return '$_temp0';
  }

  @override
  String nWeatherStationsWithIndefiniteArticle(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'weather stations',
      two: 'weather stations',
      one: 'a weather station',
    );
    return '$_temp0';
  }

  @override
  String nWeatherStationsWithDefiniteArticle(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'weather stations',
      two: 'weather stations',
      one: 'the weather station',
    );
    return '$_temp0';
  }

  @override
  String nWeatherStationsWithArticulatedPreposition(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'the weather stations',
      two: 'the weather stations',
      one: 'the weather station',
    );
    return '$_temp0';
  }

  @override
  String get addWeatherStationPageTitle => 'New Weather Station';

  @override
  String get updateWeatherStationPageTitle => 'Update Weather Station';

  @override
  String pumpSwitchedOnSince(Object when) {
    return 'switched on since $when';
  }

  @override
  String get pumpsSwitchedOn => 'Pumps switched on';

  @override
  String get sectorsSwitchedOn => 'Sectors switched on';

  @override
  String get filterInForDashboard => 'Filter IN';

  @override
  String get filterOutForDashboard => 'Filter OUT';

  @override
  String get noPumpsSwitchedOn => 'No pumps switched on at the moment';

  @override
  String get noSectorsSwitchedOn => 'No sectors switched on at the moment';
}
