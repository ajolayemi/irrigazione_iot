import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'irrigazione_iot'**
  String get appTitle;

  /// The title of the home page
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homePageTitle;

  /// The title of the email form field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailFormFieldTitle;

  /// The title of the password form field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordFormFieldTitle;

  /// The title of the sign in button
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButtonTitle;

  /// The hint text for the email form field
  ///
  /// In en, this message translates to:
  /// **'example@example.com'**
  String get emailFormHint;

  /// The hint text for the password form field
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get passwordFormHint;

  /// The title of the sign in with Google button
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get signInWithGoogleButtonTitle;

  /// No description provided for @forgotPasswordButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordButtonTitle;

  /// No description provided for @orSignWithText.
  ///
  /// In en, this message translates to:
  /// **'or sign in with'**
  String get orSignWithText;

  /// No description provided for @invalidEmailErrorText.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmailErrorText;

  /// No description provided for @emptyEmailErrorText.
  ///
  /// In en, this message translates to:
  /// **'Email can\'t be empty'**
  String get emptyEmailErrorText;

  /// The error message that is displayed when the password is empty
  ///
  /// In en, this message translates to:
  /// **'Password is too short, it has to be a minimum of {minPasswordLength} characters'**
  String shortPasswordErrorText(int minPasswordLength);

  /// No description provided for @emptyPasswordErrorText.
  ///
  /// In en, this message translates to:
  /// **'Password can\'t be empty'**
  String get emptyPasswordErrorText;

  /// No description provided for @settingsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsPageTitle;

  /// No description provided for @collectorPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Collectors'**
  String get collectorPageTitle;

  /// No description provided for @pumpPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Pumps'**
  String get pumpPageTitle;

  /// No description provided for @meteoPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Meteo'**
  String get meteoPageTitle;

  /// No description provided for @sectorPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Sectors'**
  String get sectorPageTitle;

  /// No description provided for @graphsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Graphs'**
  String get graphsPageTitle;

  /// No description provided for @morePageTitle.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get morePageTitle;

  /// No description provided for @chooseCompany.
  ///
  /// In en, this message translates to:
  /// **'Choose a company'**
  String get chooseCompany;

  /// The welcome message that is displayed on the home page
  ///
  /// In en, this message translates to:
  /// **'Welcome, {username}!'**
  String welcome(Object username);

  /// No description provided for @alertDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get alertDialogCancel;

  /// No description provided for @alertDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get alertDialogConfirm;

  /// No description provided for @alertDialogDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get alertDialogDelete;

  /// No description provided for @genericAlertDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get genericAlertDialogTitle;

  /// The last time a pump status was switched on
  ///
  /// In en, this message translates to:
  /// **'last update {when}'**
  String pumpFlowLastUpdate(String when);

  /// No description provided for @genericSaveButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get genericSaveButtonLabel;

  /// No description provided for @genericUpdateButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get genericUpdateButtonLabel;

  /// The content of the alert dialog that is displayed when the user wants to switch on things like pumps, sectors
  ///
  /// In en, this message translates to:
  /// **'You\'re about to switch on {name}'**
  String onStatusUpdateAlertDialogContent(Object name);

  /// The content of the alert dialog that is displayed when the user wants to switch on things like pumps, sectors
  ///
  /// In en, this message translates to:
  /// **'You\'re about to switch off {name}'**
  String offStatusUpdateAlertDialogContent(Object name);

  /// No description provided for @onStatusDialogConfirmButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Switch On'**
  String get onStatusDialogConfirmButtonTitle;

  /// No description provided for @offStatusDialogConfirmButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Switch Off'**
  String get offStatusDialogConfirmButtonTitle;

  /// No description provided for @statusListTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Current Status'**
  String get statusListTileTitle;

  /// No description provided for @onStatusValue.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get onStatusValue;

  /// No description provided for @offStatusValue.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get offStatusValue;

  /// The message that is displayed when the user doesn't have a company associated with their account
  ///
  /// In en, this message translates to:
  /// **'Hello {username}!\nThere is no company associated with your account in our database'**
  String noCompanyFoundForUser(Object username);

  /// No description provided for @logInWithAnotherAccount.
  ///
  /// In en, this message translates to:
  /// **'Change Account'**
  String get logInWithAnotherAccount;

  /// No description provided for @addNewPumpPageTitle.
  ///
  /// In en, this message translates to:
  /// **'New Pump'**
  String get addNewPumpPageTitle;

  /// No description provided for @updatePumpPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Pump'**
  String get updatePumpPageTitle;

  /// No description provided for @pumpNameFormHint.
  ///
  /// In en, this message translates to:
  /// **'eg: Pompa Giardino'**
  String get pumpNameFormHint;

  /// No description provided for @pumpVolumeCapacityFormFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Volume capacity'**
  String get pumpVolumeCapacityFormFieldTitle;

  /// No description provided for @pumpVolumeCapacityFormHint.
  ///
  /// In en, this message translates to:
  /// **'eg: 1000'**
  String get pumpVolumeCapacityFormHint;

  /// No description provided for @pumpKwFormFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Power (kW)'**
  String get pumpKwFormFieldTitle;

  /// No description provided for @pumpKwFormHint.
  ///
  /// In en, this message translates to:
  /// **'eg: 50'**
  String get pumpKwFormHint;

  /// No description provided for @onCommandFormFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'On command'**
  String get onCommandFormFieldTitle;

  /// No description provided for @onCommandFormHint.
  ///
  /// In en, this message translates to:
  /// **'eg: 1'**
  String get onCommandFormHint;

  /// No description provided for @offCommandFormFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Off command'**
  String get offCommandFormFieldTitle;

  /// No description provided for @offCommandFormHint.
  ///
  /// In en, this message translates to:
  /// **'eg: 2'**
  String get offCommandFormHint;

  /// No description provided for @formGenericSaveDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Do you want to save the data?'**
  String get formGenericSaveDialogTitle;

  /// The content of the alert dialog that is displayed when the user wants to save data
  ///
  /// In en, this message translates to:
  /// **'You\'re about to save the data for {fieldName} in the database'**
  String formGenericSaveDialogContent(Object fieldName);

  /// No description provided for @formGenericUpdateDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Do you want to update the data?'**
  String get formGenericUpdateDialogTitle;

  /// No description provided for @formGenericUpdateDialogContent.
  ///
  /// In en, this message translates to:
  /// **'You\'re about to update the data for {fieldName} in the database'**
  String formGenericUpdateDialogContent(Object fieldName);

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get notAvailable;

  /// The title of the delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Clicking on delete will remove all data related to {name} from database'**
  String deleteConfirmationDialogTitle(Object name);

  /// The last time a sector was irrigated
  ///
  /// In en, this message translates to:
  /// **'last irrigation {when}'**
  String sectorLastIrrigation(String when);

  /// No description provided for @sectorNameHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: ME8'**
  String get sectorNameHintText;

  /// No description provided for @sectorSpecie.
  ///
  /// In en, this message translates to:
  /// **'Specie'**
  String get sectorSpecie;

  /// No description provided for @sectorSpecieHintText.
  ///
  /// In en, this message translates to:
  /// **'select a specie...'**
  String get sectorSpecieHintText;

  /// No description provided for @sectorVariety.
  ///
  /// In en, this message translates to:
  /// **'Variety'**
  String get sectorVariety;

  /// No description provided for @sectorVarietyHintText.
  ///
  /// In en, this message translates to:
  /// **'select a variety...'**
  String get sectorVarietyHintText;

  /// No description provided for @sectorOccupiedArea.
  ///
  /// In en, this message translates to:
  /// **'Occupied area'**
  String get sectorOccupiedArea;

  /// No description provided for @sectorOccupiedAreaHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: 100'**
  String get sectorOccupiedAreaHintText;

  /// No description provided for @sectorNumberOfPlants.
  ///
  /// In en, this message translates to:
  /// **'Number of plants'**
  String get sectorNumberOfPlants;

  /// No description provided for @sectorNumberOfPlantsHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: 100'**
  String get sectorNumberOfPlantsHintText;

  /// No description provided for @sectorUnitConsumptionPerHour.
  ///
  /// In en, this message translates to:
  /// **'Consumption per plant (l/h)'**
  String get sectorUnitConsumptionPerHour;

  /// No description provided for @sectorUnitConsumptionPerHourHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: 1'**
  String get sectorUnitConsumptionPerHourHintText;

  /// No description provided for @sectorTotalConsumption.
  ///
  /// In en, this message translates to:
  /// **'Total consumption (l/h)'**
  String get sectorTotalConsumption;

  /// No description provided for @sectorIrrigationSystem.
  ///
  /// In en, this message translates to:
  /// **'Irrigation system'**
  String get sectorIrrigationSystem;

  /// No description provided for @sectorIrrigationSource.
  ///
  /// In en, this message translates to:
  /// **'Irrigation source'**
  String get sectorIrrigationSource;

  /// No description provided for @sectorNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get sectorNotes;

  /// No description provided for @sectorConnectedPumps.
  ///
  /// In en, this message translates to:
  /// **'Connected pump'**
  String get sectorConnectedPumps;

  /// No description provided for @sectorLastIrrigationEmpty.
  ///
  /// In en, this message translates to:
  /// **'Never irrigated'**
  String get sectorLastIrrigationEmpty;

  /// No description provided for @sectorLastIrrigationForTile.
  ///
  /// In en, this message translates to:
  /// **'Last irrigated'**
  String get sectorLastIrrigationForTile;

  /// No description provided for @addSectorPageTitle.
  ///
  /// In en, this message translates to:
  /// **'New Sector'**
  String get addSectorPageTitle;

  /// No description provided for @updateSectorPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Sector'**
  String get updateSectorPageTitle;

  /// No description provided for @selectASpecie.
  ///
  /// In en, this message translates to:
  /// **'Select a specie'**
  String get selectASpecie;

  /// No description provided for @selectAnOption.
  ///
  /// In en, this message translates to:
  /// **'Select an option'**
  String get selectAnOption;

  /// The error message that is displayed when a form field value is too long
  ///
  /// In en, this message translates to:
  /// **'Field value is too long, it has to be a maximum of {max} characters'**
  String fieldTooLongErrorText(int max);

  /// No description provided for @emptyFormFieldErrorText.
  ///
  /// In en, this message translates to:
  /// **'Field can\'t be empty'**
  String get emptyFormFieldErrorText;

  /// No description provided for @notANumberErrorText.
  ///
  /// In en, this message translates to:
  /// **'Field has to be a number'**
  String get notANumberErrorText;

  /// No description provided for @notGreaterThanZeroErrorText.
  ///
  /// In en, this message translates to:
  /// **'Field has to be greater than 0'**
  String get notGreaterThanZeroErrorText;

  /// The error message that is displayed when a form field command value is already in use
  ///
  /// In en, this message translates to:
  /// **'This command value is already in use for another {fieldName}'**
  String commandAlreadyInUseErrorText(Object fieldName);

  /// The error message that is displayed when the user tries to use the same command to switch on and switch off a pump
  ///
  /// In en, this message translates to:
  /// **'You can\'t use the same command to switch on and switch off {fieldName}'**
  String duplicateCommandsInFormErrorText(String fieldName);

  /// The error message that is displayed when a form field value is already in use
  ///
  /// In en, this message translates to:
  /// **'This value is already in use for another {fieldName}'**
  String fieldValueAlreadyInUseErrorText(String fieldName);

  /// The pluralized version of the word 'pump'
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{pump} =2{pumps} other {pumps}}'**
  String nPumps(int n);

  /// The pluralized version of the word 'pump' with an indefinite article
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{a pump} =2{pumps} other {pumps}}'**
  String nPumpsWithIndefiniteArticle(int n);

  /// The pluralized version of the word 'pump' with a definite article
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{the pump} =2{pumps} other {pumps}}'**
  String nPumpsWithDefiniteArticle(int n);

  /// The pluralized version of the word 'pump' with an articulated preposition
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{the pump} =2{the pumps} other {the pumps}}'**
  String nPumpsWithArticulatedPreposition(int n);

  /// The pluralized version of the word 'sector'
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{sector} =2{sectors} other {sectors}}'**
  String nSectors(int n);

  /// The pluralized version of the word 'sector' with an indefinite article
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{a sector} =2{sectors} other {sectors}}'**
  String nSectorsWithIndefiniteArticle(int n);

  /// The pluralized version of the word 'sector' with a definite article
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{the sector} =2{sectors} other {sectors}}'**
  String nSectorsWithDefiniteArticle(int n);

  /// The pluralized version of the word 'sector' with an articulated preposition
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{the sector} =2{the sectors} other {the sectors}}'**
  String nSectorsWithArticulatedPreposition(int n);

  /// The placeholder text that is displayed when there is no data in the database
  ///
  /// In en, this message translates to:
  /// **'No {name} was found in the database'**
  String emptyDataPlaceholder(Object name);

  /// No description provided for @addNewButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get addNewButtonLabel;

  /// No description provided for @connectPumpToSectorPageTile.
  ///
  /// In en, this message translates to:
  /// **'Select a pump'**
  String get connectPumpToSectorPageTile;

  /// No description provided for @noPumpConnectedToSectorErrorText.
  ///
  /// In en, this message translates to:
  /// **'You have to connect at least one pump to this sector'**
  String get noPumpConnectedToSectorErrorText;

  /// No description provided for @pumpLastDispensationForTile.
  ///
  /// In en, this message translates to:
  /// **'Was last switched on'**
  String get pumpLastDispensationForTile;

  /// No description provided for @pumpLastDispensationEmpty.
  ///
  /// In en, this message translates to:
  /// **'Never switched on'**
  String get pumpLastDispensationEmpty;

  /// No description provided for @pumpTotalDispensedLitres.
  ///
  /// In en, this message translates to:
  /// **'Total litres dispensed'**
  String get pumpTotalDispensedLitres;

  /// The pluralized version of the word 'collector'
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{collector} =2{collectors} other{collectors}}'**
  String nCollectors(int n);

  /// The pluralized version of the word 'collector' with an indefinite article
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{a collector} =2{collectors} other{collectors}}'**
  String nCollectorsWithIndefiniteArticle(int n);

  /// The pluralized version of the word 'collector' with a definite article
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{the collector} =2{collectors} other{collectors}}'**
  String nCollectorsWithDefiniteArticle(int n);

  /// The pluralized version of the word 'collector' with an articulated preposition
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{the collector} =2{the collectors} other{the collectors}}'**
  String nCollectorsWithArticulatedPreposition(int n);

  /// No description provided for @addNewCollectorPageTitle.
  ///
  /// In en, this message translates to:
  /// **'New Collector'**
  String get addNewCollectorPageTitle;

  /// No description provided for @updateCollectorPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Collector'**
  String get updateCollectorPageTitle;

  /// No description provided for @collectorName.
  ///
  /// In en, this message translates to:
  /// **'Collector name'**
  String get collectorName;

  /// No description provided for @collectorNameHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: Collettore Giardino'**
  String get collectorNameHintText;

  /// No description provided for @collectorFilterName.
  ///
  /// In en, this message translates to:
  /// **'Filter (filtro) name '**
  String get collectorFilterName;

  /// No description provided for @collectorFilterNameHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: Filtro 1'**
  String get collectorFilterNameHintText;

  /// No description provided for @nSelectedSectors.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{0 sectors selected} =1{1 sector selected} other{{n} sectors selected}}'**
  String nSelectedSectors(num n);

  /// No description provided for @connectSectorToCollectorPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Sectors'**
  String get connectSectorToCollectorPageTitle;

  /// No description provided for @collectorConnectedSectors.
  ///
  /// In en, this message translates to:
  /// **'Connected sectors'**
  String get collectorConnectedSectors;

  /// No description provided for @noSectorConnectedToCollectorErrorText.
  ///
  /// In en, this message translates to:
  /// **'You have to connect at least one sector to this collector'**
  String get noSectorConnectedToCollectorErrorText;

  /// No description provided for @genericConfirmButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get genericConfirmButtonLabel;

  /// No description provided for @allSectorsAreConnectedToACollector.
  ///
  /// In en, this message translates to:
  /// **'All available sectors have already been connected to a collector'**
  String get allSectorsAreConnectedToACollector;

  /// No description provided for @nConnectedSectors.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{0 sectors connected} =1{1 sector connected} other{{n} sectors connected}}'**
  String nConnectedSectors(num n);

  /// No description provided for @batteryLevel.
  ///
  /// In en, this message translates to:
  /// **'Battery:'**
  String get batteryLevel;

  /// No description provided for @filterPressureDifference.
  ///
  /// In en, this message translates to:
  /// **'Filter diff:'**
  String get filterPressureDifference;

  /// No description provided for @iotBoardsMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Boards'**
  String get iotBoardsMenuTitle;

  /// No description provided for @settingsMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsMenuTitle;

  /// No description provided for @profilePageTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profilePageTitle;

  /// No description provided for @logOutButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logOutButtonTitle;

  /// No description provided for @logOutAlertDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logOutAlertDialogTitle;

  /// No description provided for @logOutAlertDialogContent.
  ///
  /// In en, this message translates to:
  /// **'You will be logged out of the application'**
  String get logOutAlertDialogContent;

  /// No description provided for @logOutAlertDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logOutAlertDialogConfirm;

  /// The pluralized version of the word 'board'
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{board} =2{boards} other{boards}}'**
  String nBoards(int n);

  /// The pluralized version of the word 'board' with an indefinite article
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{a board} =2{boards} other{boards}}'**
  String nBoardsWithIndefiniteArticle(int n);

  /// The pluralized version of the word 'board' with a definite article
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{the board} =2{boards} other{boards}}'**
  String nBoardsWithDefiniteArticle(int n);

  /// The pluralized version of the word 'board' with an articulated preposition
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{the board} =2{the boards} other{the boards}}'**
  String nBoardsWithArticulatedPreposition(int n);

  /// No description provided for @addNewBoardPageTitle.
  ///
  /// In en, this message translates to:
  /// **'New Board'**
  String get addNewBoardPageTitle;

  /// No description provided for @updateBoardPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Board'**
  String get updateBoardPageTitle;

  /// No description provided for @boardNameHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: arduino mkr16'**
  String get boardNameHintText;

  /// No description provided for @boardModel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get boardModel;

  /// No description provided for @boardModelHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: MKR 1010'**
  String get boardModelHintText;

  /// No description provided for @boardSerialNumber.
  ///
  /// In en, this message translates to:
  /// **'Serial number'**
  String get boardSerialNumber;

  /// No description provided for @boardSerialNumberHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: 123456789'**
  String get boardSerialNumberHintText;

  /// No description provided for @boardConnectedCollector.
  ///
  /// In en, this message translates to:
  /// **'Connected Collector'**
  String get boardConnectedCollector;

  /// No description provided for @boardConnectedCollectorHintText.
  ///
  /// In en, this message translates to:
  /// **'Select a collector'**
  String get boardConnectedCollectorHintText;

  /// No description provided for @allCollectorsAreConnectedToABoard.
  ///
  /// In en, this message translates to:
  /// **'All available collectors have already been connected to a board'**
  String get allCollectorsAreConnectedToABoard;

  /// No description provided for @connectCollectorToBoardPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Select a collector'**
  String get connectCollectorToBoardPageTitle;

  /// No description provided for @nSelectedCollectors.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{0 collectors selected} =1{1 collector selected} other{{n} collectors selected}}'**
  String nSelectedCollectors(num n);

  /// No description provided for @noCollectorConnectedToBoardErrorText.
  ///
  /// In en, this message translates to:
  /// **'You have to connect at least one collector to this board'**
  String get noCollectorConnectedToBoardErrorText;

  /// No description provided for @userProfileDetailsName.
  ///
  /// In en, this message translates to:
  /// **'Names'**
  String get userProfileDetailsName;

  /// No description provided for @userProfileDetailsEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get userProfileDetailsEmail;

  /// No description provided for @userProfileDetailsCurrentCompany.
  ///
  /// In en, this message translates to:
  /// **'Current company profile'**
  String get userProfileDetailsCurrentCompany;

  /// No description provided for @companyProfileMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Company Profile'**
  String get companyProfileMenuTitle;

  /// No description provided for @companyUsersMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'My Company Users'**
  String get companyUsersMenuTitle;

  /// No description provided for @companyNameHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: My Company'**
  String get companyNameHintText;

  /// No description provided for @companyRegisteredAddress.
  ///
  /// In en, this message translates to:
  /// **'Registered office address'**
  String get companyRegisteredAddress;

  /// No description provided for @companyRegisteredAddressHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: 123 Main Street, 12345, City, Country'**
  String get companyRegisteredAddressHintText;

  /// No description provided for @companyVatNumber.
  ///
  /// In en, this message translates to:
  /// **'VAT number'**
  String get companyVatNumber;

  /// No description provided for @companyVatNumberHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: 123456789'**
  String get companyVatNumberHintText;

  /// No description provided for @companyFiscalCode.
  ///
  /// In en, this message translates to:
  /// **'Fiscal code'**
  String get companyFiscalCode;

  /// No description provided for @companyFiscalCodeHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: 123456789'**
  String get companyFiscalCodeHintText;

  /// No description provided for @companyEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get companyEmail;

  /// No description provided for @companyEmailHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: email@company.com'**
  String get companyEmailHintText;

  /// No description provided for @companyPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get companyPhone;

  /// No description provided for @companyPhoneHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: +123456789'**
  String get companyPhoneHintText;

  /// The error message that is displayed when one of two dependent fields is empty
  ///
  /// In en, this message translates to:
  /// **'One between {firstFieldName} and {secondFieldName} has to be filled'**
  String dependentFieldsEmptyErrorText(Object firstFieldName, Object secondFieldName);

  /// No description provided for @addNewCompanyPageTitle.
  ///
  /// In en, this message translates to:
  /// **'New Company'**
  String get addNewCompanyPageTitle;

  /// No description provided for @updateCompanyPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Company'**
  String get updateCompanyPageTitle;

  /// The pluralized version of the word 'company'
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{company} =2{companies} other{companies}}'**
  String nCompany(int n);

  /// No description provided for @noUsersConnectedWithCompany.
  ///
  /// In en, this message translates to:
  /// **'You have no registered users associated with your company'**
  String get noUsersConnectedWithCompany;

  /// No description provided for @companyUserFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get companyUserFullName;

  /// No description provided for @companyUserFullNameHintTest.
  ///
  /// In en, this message translates to:
  /// **'eg: John Doe'**
  String get companyUserFullNameHintTest;

  /// No description provided for @companyUserEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get companyUserEmail;

  /// No description provided for @companyUserEmailHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: example@example.com'**
  String get companyUserEmailHintText;

  /// No description provided for @companyUserRole.
  ///
  /// In en, this message translates to:
  /// **'Assign a role'**
  String get companyUserRole;

  /// No description provided for @companyUserRoleHintText.
  ///
  /// In en, this message translates to:
  /// **'Select a role'**
  String get companyUserRoleHintText;

  /// No description provided for @companyUserAssignedRoleForDetails.
  ///
  /// In en, this message translates to:
  /// **'Assigned role'**
  String get companyUserAssignedRoleForDetails;

  /// No description provided for @companyUserAddedOn.
  ///
  /// In en, this message translates to:
  /// **'Added on'**
  String get companyUserAddedOn;

  /// No description provided for @companyUserLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated'**
  String get companyUserLastUpdated;

  /// No description provided for @addNewCompanyUserPageTitle.
  ///
  /// In en, this message translates to:
  /// **'New User'**
  String get addNewCompanyUserPageTitle;

  /// No description provided for @updateCompanyUserPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Update User'**
  String get updateCompanyUserPageTitle;

  /// No description provided for @emailAlreadyInUseErrorText.
  ///
  /// In en, this message translates to:
  /// **'This email is already in use'**
  String get emailAlreadyInUseErrorText;

  /// The pluralized version of the word 'company user'
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{company user} =2{company users} other{company users}}'**
  String nCompanyUsers(int n);

  /// No description provided for @assignRoleDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Assign a role'**
  String get assignRoleDialogTitle;

  /// No description provided for @me.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get me;

  /// No description provided for @companyUserDismissalDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this user?'**
  String get companyUserDismissalDialogTitle;

  /// The content of the alert dialog that is displayed when the user wants to delete a company user
  ///
  /// In en, this message translates to:
  /// **'You\'re about to delete {companyUserName} as a user'**
  String companyUserDismissalDialogContent(Object companyUserName);

  /// No description provided for @cantDeleteYourselfDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'You can\'t delete yourself as a user'**
  String get cantDeleteYourselfDialogTitle;

  /// No description provided for @noUppercaseInPasswordErrorText.
  ///
  /// In en, this message translates to:
  /// **'Password has to contain at least one uppercase letter'**
  String get noUppercaseInPasswordErrorText;

  /// No description provided for @noLowercaseInPasswordErrorText.
  ///
  /// In en, this message translates to:
  /// **'Password has to contain at least one lowercase letter'**
  String get noLowercaseInPasswordErrorText;

  /// No description provided for @noNumberInPasswordErrorText.
  ///
  /// In en, this message translates to:
  /// **'Password has to contain at least one number'**
  String get noNumberInPasswordErrorText;

  /// No description provided for @noSpecialCharacterInPasswordErrorText.
  ///
  /// In en, this message translates to:
  /// **'Password has to contain at least one special character'**
  String get noSpecialCharacterInPasswordErrorText;

  /// No description provided for @passwordsDoNotMatchErrorText.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatchErrorText;

  /// No description provided for @invalidCredentialsErrorText.
  ///
  /// In en, this message translates to:
  /// **'The email or password you entered is incorrect'**
  String get invalidCredentialsErrorText;

  /// No description provided for @introductorySignInText.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your registered account details to continue'**
  String get introductorySignInText;

  /// No description provided for @noAccountText.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountText;

  /// No description provided for @signUpText.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpText;

  /// No description provided for @signUpButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButtonTitle;

  /// No description provided for @confirmPasswordFormFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordFormFieldTitle;

  /// No description provided for @confirmPasswordFormHint.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get confirmPasswordFormHint;

  /// No description provided for @alreadyHaveAnAccountText.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccountText;

  /// No description provided for @nameFormFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameFormFieldTitle;

  /// No description provided for @nameFormHint.
  ///
  /// In en, this message translates to:
  /// **'John'**
  String get nameFormHint;

  /// No description provided for @surnameFormFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get surnameFormFieldTitle;

  /// No description provided for @surnameFormHint.
  ///
  /// In en, this message translates to:
  /// **'Doe'**
  String get surnameFormHint;

  /// No description provided for @signInPageIntroductoryTitleText.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get signInPageIntroductoryTitleText;

  /// No description provided for @signUpPageIntroductoryTitleText.
  ///
  /// In en, this message translates to:
  /// **'Get started with us!'**
  String get signUpPageIntroductoryTitleText;

  /// No description provided for @signUpPageIntroductorySubtitleText.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get signUpPageIntroductorySubtitleText;

  /// No description provided for @signInPageIntroductorySubtitleText.
  ///
  /// In en, this message translates to:
  /// **'Sign into your account to continue'**
  String get signInPageIntroductorySubtitleText;

  /// No description provided for @mqttMessageNameFormFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Code name in MQTT message'**
  String get mqttMessageNameFormFieldTitle;

  /// No description provided for @mqttMessageNameFormHint.
  ///
  /// In en, this message translates to:
  /// **'alias name in mqtt msgs...'**
  String get mqttMessageNameFormHint;

  /// No description provided for @itemHasFilter.
  ///
  /// In en, this message translates to:
  /// **'Has a filter connected?'**
  String get itemHasFilter;

  /// No description provided for @selectAPumpHintText.
  ///
  /// In en, this message translates to:
  /// **'select a pump...'**
  String get selectAPumpHintText;

  /// No description provided for @selectAVarietyPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Select a variety'**
  String get selectAVarietyPageTitle;

  /// No description provided for @selectAnOptionHintText.
  ///
  /// In en, this message translates to:
  /// **'select an option...'**
  String get selectAnOptionHintText;

  /// No description provided for @mqttTopicNameFormFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Name in MQTT topic'**
  String get mqttTopicNameFormFieldTitle;

  /// No description provided for @mqttTopicNameFormHint.
  ///
  /// In en, this message translates to:
  /// **'alias name in mqtt topic...'**
  String get mqttTopicNameFormHint;

  /// No description provided for @switchOn.
  ///
  /// In en, this message translates to:
  /// **'Switch On'**
  String get switchOn;

  /// No description provided for @switchOff.
  ///
  /// In en, this message translates to:
  /// **'Switch Off'**
  String get switchOff;

  /// No description provided for @entityCharacteristics.
  ///
  /// In en, this message translates to:
  /// **'Characteristics'**
  String get entityCharacteristics;

  /// No description provided for @entityStatistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get entityStatistics;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @mqttOnCommand.
  ///
  /// In en, this message translates to:
  /// **'On Command (MQTT)'**
  String get mqttOnCommand;

  /// No description provided for @mqttOffCommand.
  ///
  /// In en, this message translates to:
  /// **'Off Command (MQTT)'**
  String get mqttOffCommand;

  /// No description provided for @lastFilterInPressure.
  ///
  /// In en, this message translates to:
  /// **'Last filter in pressure'**
  String get lastFilterInPressure;

  /// No description provided for @lastFilterOutPressure.
  ///
  /// In en, this message translates to:
  /// **'Last filter out pressure'**
  String get lastFilterOutPressure;

  /// No description provided for @lastFilterPressureDifference.
  ///
  /// In en, this message translates to:
  /// **'Last filter pressure difference'**
  String get lastFilterPressureDifference;

  /// No description provided for @pressure.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get pressure;

  /// No description provided for @sensorPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Sensors'**
  String get sensorPageTitle;

  /// The pluralized version of the word 'sensor'
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{sensor} =2{sensors} other{sensors}}'**
  String nSensors(int n);

  /// The pluralized version of the word 'sensor' with an indefinite article
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{a sensor} =2{sensors} other{sensors}}'**
  String nSensorsWithIndefiniteArticle(int n);

  /// The pluralized version of the word 'sensor' with a definite article
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{the sensor} =2{sensors} other{sensors}}'**
  String nSensorsWithDefiniteArticle(int n);

  /// The pluralized version of the word 'sensor' with an articulated preposition
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{the sensor} =2{the sensors} other{the sensors}}'**
  String nSensorsWithArticulatedPreposition(int n);

  /// No description provided for @addSensorPageTitle.
  ///
  /// In en, this message translates to:
  /// **'New Sensor'**
  String get addSensorPageTitle;

  /// No description provided for @updateSensorPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Sensor'**
  String get updateSensorPageTitle;

  /// No description provided for @airTemperature.
  ///
  /// In en, this message translates to:
  /// **'Air Temperature'**
  String get airTemperature;

  /// No description provided for @airHumidity.
  ///
  /// In en, this message translates to:
  /// **'Air Humidity'**
  String get airHumidity;

  /// No description provided for @lightIntensity.
  ///
  /// In en, this message translates to:
  /// **'Light Intensity'**
  String get lightIntensity;

  /// No description provided for @barometricPressure.
  ///
  /// In en, this message translates to:
  /// **'Barometric Pressure'**
  String get barometricPressure;

  /// No description provided for @windDirection.
  ///
  /// In en, this message translates to:
  /// **'Wind Direction'**
  String get windDirection;

  /// No description provided for @windSpeed.
  ///
  /// In en, this message translates to:
  /// **'Wind Speed'**
  String get windSpeed;

  /// No description provided for @rainfallHourly.
  ///
  /// In en, this message translates to:
  /// **'Rainfall Hourly'**
  String get rainfallHourly;

  /// No description provided for @uvIndex.
  ///
  /// In en, this message translates to:
  /// **'UV Index'**
  String get uvIndex;

  /// No description provided for @deviceEui.
  ///
  /// In en, this message translates to:
  /// **'Device EUI'**
  String get deviceEui;

  /// No description provided for @sensorsMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Sensors'**
  String get sensorsMenuTitle;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated'**
  String get lastUpdated;

  /// No description provided for @connectedSector.
  ///
  /// In en, this message translates to:
  /// **'Connected sector'**
  String get connectedSector;

  /// No description provided for @weatherStationNameHintText.
  ///
  /// In en, this message translates to:
  /// **'eg: Stazione meteo 1'**
  String get weatherStationNameHintText;

  /// No description provided for @weatherStationEuiHintText.
  ///
  /// In en, this message translates to:
  /// **'device unique identifier...'**
  String get weatherStationEuiHintText;

  /// No description provided for @selectASectorPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Select a sector'**
  String get selectASectorPageTitle;

  /// No description provided for @historyPageTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyPageTitle;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No history'**
  String get noHistory;

  /// No description provided for @registerYourCompany.
  ///
  /// In en, this message translates to:
  /// **'Register your company'**
  String get registerYourCompany;

  /// No description provided for @loginToYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Login to your account'**
  String get loginToYourAccount;

  /// No description provided for @welcomePageIntro.
  ///
  /// In en, this message translates to:
  /// **'We\'re glad to have you here! Please select an option to continue'**
  String get welcomePageIntro;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @companyCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your company has been created successfully!'**
  String get companyCreatedSuccessfully;

  /// No description provided for @weatherStationPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Weather Stations'**
  String get weatherStationPageTitle;

  /// The pluralized version of the word 'weather station'
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{weather station} =2{weather stations} other{weather stations}}'**
  String nWeatherStations(int n);

  /// The pluralized version of the word 'weather station' with an indefinite article
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{a weather station} =2{weather stations} other{weather stations}}'**
  String nWeatherStationsWithIndefiniteArticle(int n);

  /// The pluralized version of the word 'weather station' with a definite article
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{the weather station} =2{weather stations} other{weather stations}}'**
  String nWeatherStationsWithDefiniteArticle(int n);

  /// The pluralized version of the word 'weather station' with an articulated preposition
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{the weather station} =2{the weather stations} other{the weather stations}}'**
  String nWeatherStationsWithArticulatedPreposition(int n);

  /// No description provided for @addWeatherStationPageTitle.
  ///
  /// In en, this message translates to:
  /// **'New Weather Station'**
  String get addWeatherStationPageTitle;

  /// No description provided for @updateWeatherStationPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Weather Station'**
  String get updateWeatherStationPageTitle;

  /// No description provided for @pumpSwitchedOnSince.
  ///
  /// In en, this message translates to:
  /// **'switched on since {when}'**
  String pumpSwitchedOnSince(Object when);

  /// No description provided for @pumpsSwitchedOn.
  ///
  /// In en, this message translates to:
  /// **'Pumps switched on'**
  String get pumpsSwitchedOn;

  /// No description provided for @sectorsSwitchedOn.
  ///
  /// In en, this message translates to:
  /// **'Sectors switched on'**
  String get sectorsSwitchedOn;

  /// No description provided for @filterInForDashboard.
  ///
  /// In en, this message translates to:
  /// **'Filter IN'**
  String get filterInForDashboard;

  /// No description provided for @filterOutForDashboard.
  ///
  /// In en, this message translates to:
  /// **'Filter OUT'**
  String get filterOutForDashboard;

  /// No description provided for @noPumpsSwitchedOn.
  ///
  /// In en, this message translates to:
  /// **'No pumps switched on at the moment'**
  String get noPumpsSwitchedOn;

  /// No description provided for @noSectorsSwitchedOn.
  ///
  /// In en, this message translates to:
  /// **'No sectors switched on at the moment'**
  String get noSectorsSwitchedOn;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
