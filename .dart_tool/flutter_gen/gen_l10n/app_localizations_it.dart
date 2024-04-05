import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'irrigazione_iot';

  @override
  String get homePageTitle => 'Home';

  @override
  String get emailFormFieldTitle => 'Email';

  @override
  String get passwordFormFieldTitle => 'Password';

  @override
  String get signInButtonTitle => 'Accedi';

  @override
  String get emailFormHint => 'esempio@esempio.com';

  @override
  String get passwordFormHint => '••••••••';

  @override
  String get signInWithGoogleButtonTitle => 'Google';

  @override
  String get forgotPasswordButtonTitle => 'Password dimenticata?';

  @override
  String get orText => 'oppure accedi con';

  @override
  String get invalidEmailErrorText => 'Indirizzo email non valido';

  @override
  String get emptyEmailErrorText => 'Il campo email non può essere vuoto';

  @override
  String shortPasswordErrorText(int minPasswordLength) {
    return 'La password inserita è troppo corta, deve essere minimo $minPasswordLength caratteri';
  }

  @override
  String get emptyPasswordErrorText => 'Il campo password non può essere vuoto';

  @override
  String get settingsPageTitle => 'Impostazione';

  @override
  String get collectorPageTitle => 'Collettori';

  @override
  String get pumpPageTitle => 'Pompe';

  @override
  String get meteoPageTitle => 'Meteo';

  @override
  String get sectorPageTitle => 'Settori';

  @override
  String get graphsPageTitle => 'Grafici';

  @override
  String get morePageTitle => 'Altro';

  @override
  String get chooseCompany => 'Scegli un\'azienda';

  @override
  String welcome(Object username) {
    return 'Ciao, $username!';
  }

  @override
  String get alertDialogCancel => 'Annulla';

  @override
  String get alertDialogConfirm => 'Conferma';

  @override
  String get alertDialogDelete => 'Elimina';

  @override
  String get genericAlertDialogTitle => 'Sei sicuro?';

  @override
  String pumpStatusLastSwitchedOn(String when) {
    return 'ultima erogazione: $when';
  }

  @override
  String get genericSaveButtonLabel => 'Salva';

  @override
  String get genericUpdateButtonLabel => 'Aggiorna';

  @override
  String onStatusUpdateAlertDialogContent(Object name) {
    return 'Stai per accendere $name';
  }

  @override
  String offStatusUpdateAlertDialogContent(Object name) {
    return 'Stai per spegnere $name';
  }

  @override
  String get onStatusDialogConfirmButtonTitle => 'Accendi';

  @override
  String get offStatusDialogConfirmButtonTitle => 'Spegni';

  @override
  String get statusListTileTitle => 'Stato Attuale';

  @override
  String get onStatusValue => 'On';

  @override
  String get offStatusValue => 'Off';

  @override
  String noCompanyFoundForUser(Object username) {
    return 'Ciao $username!\nNon ci risultano aziende associate al tuo account nel nostro database';
  }

  @override
  String get logInWithAnotherAccount => 'Cambia account';

  @override
  String get addNewPumpPageTitle => 'Nuova Pompa';

  @override
  String get updatePumpPageTitle => 'Aggiorna Pompa';

  @override
  String get pumpNameFormFieldTitle => 'Nome';

  @override
  String get pumpNameFormHint => 'es: Pompa Giardino';

  @override
  String get pumpVolumeCapacityFormFieldTitle => 'Portata Volumetrica';

  @override
  String get pumpVolumeCapacityFormHint => 'es: 1000';

  @override
  String get pumpKwFormFieldTitle => 'Consumo Energetico (kW)';

  @override
  String get pumpKwFormHint => 'es: 50';

  @override
  String get pumpOnCommandFormFieldTitle => 'On Command';

  @override
  String get pumpOnCommandFormHint => 'es: 1';

  @override
  String get pumpOffCommandFormFieldTitle => 'Off Command';

  @override
  String get pumpOffCommandFormHint => 'es: 2';

  @override
  String get formGenericSaveDialogTitle => 'Vuoi salvare i dati?';

  @override
  String formGenericSaveDialogContent(Object fieldName) {
    return 'You\'re about to save the data for $fieldName in the database';
  }

  @override
  String get formGenericUpdateDialogTitle => 'Vuoi aggiornare i dati?';

  @override
  String formGenericUpdateDialogContent(Object fieldName) {
    return 'You\'re about to update the data for $fieldName in the database';
  }

  @override
  String get notAvailable => 'Non disponibile';

  @override
  String deleteConfirmationDialogTitle(Object name) {
    return 'Cliccando su elimina, verranno cancellati tutti i dati relativi $name';
  }

  @override
  String sectorLastIrrigation(String when) {
    return 'Ultima irrigazione: $when';
  }

  @override
  String get sectorName => 'Nome';

  @override
  String get sectorNameHintText => 'es: ME8';

  @override
  String get sectorSpecie => 'Specie';

  @override
  String get sectorSpecieHintText => 'es: Arancia';

  @override
  String get sectorVariety => 'Varietà';

  @override
  String get sectorVarietyHintText => 'es: Sanguinello';

  @override
  String get sectorOccupiedArea => 'Area Occupata';

  @override
  String get sectorOccupiedAreaHintText => 'es: 100';

  @override
  String get sectorNumberOfPlants => 'Numero di Piante';

  @override
  String get sectorNumberOfPlantsHintText => 'es: 100';

  @override
  String get sectorUnitConsumptionPerHour => 'Consumo per Pianta (l/h)';

  @override
  String get sectorUnitConsumptionPerHourHintText => 'es: 1';

  @override
  String get sectorTotalConsumption => 'Consumo Totale (l/h)';

  @override
  String get sectorIrrigationSystem => 'Sistema di Irrigazione';

  @override
  String get sectorIrrigationSystemHintText => 'es: A Goccia';

  @override
  String get sectorIrrigationSource => 'Fonte di Irrigazione';

  @override
  String get sectorIrrigationSourceHintText => 'es: Pozzo';

  @override
  String get sectorOnCommand => 'Comando Accensione';

  @override
  String get sectorOnCommandHintText => 'es: 1';

  @override
  String get sectorOffCommand => 'Comando Spegnimento';

  @override
  String get sectorOffCommandHintText => 'es: 2';

  @override
  String get sectorNotes => 'Note';

  @override
  String get sectorConnectedPumps => 'Pompe Collegate';

  @override
  String get sectorLastIrrigationEmpty => 'Mai irrigato';

  @override
  String get sectorLastIrrigationForTile => 'Ultima Irrigazione';

  @override
  String get addSectorPageTitle => 'Nuovo Settore';

  @override
  String get updateSectorPageTitle => 'Aggiorna Settore';

  @override
  String get selectASpecie => 'Selezione una specie';

  @override
  String get selectAnIrrigationSystem => 'Seleziona un sistema di irrigazione';

  @override
  String get selectAnIrrigationSource => 'Seleziona una fonte di irrigazione';

  @override
  String fieldTooLongErrorText(int max) {
    return 'Il nome inserito è troppo lungo, deve essere massimo $max caratteri';
  }

  @override
  String get emptyFormFieldErrorText => 'Il campo non può essere vuoto';

  @override
  String get notANumberErrorText => 'Il campo deve essere un numero';

  @override
  String get notGreaterThanZeroErrorText => 'Il campo deve essere maggiore di zero';

  @override
  String commandAlreadyInUseErrorText(Object fieldName) {
    return 'Questo comando è già in uso per $fieldName';
  }

  @override
  String duplicateCommandsInFormErrorText(String fieldName) {
    return 'Non puoi usare lo stesso comando per spegnere e accendere $fieldName';
  }

  @override
  String fieldValueAlreadyInUseErrorText(String fieldName) {
    return 'Il valore inserito è già in uso per $fieldName';
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
      other: 'pompe',
      two: 'pompe',
      one: 'pompa',
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
      other: 'delle pompe',
      two: 'delle pompe',
      one: 'una pompa',
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
      other: 'le pompe',
      two: 'le pompe',
      one: 'la pompa',
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
      other: 'alle pompe',
      two: 'alle pompe',
      one: 'alla pompa',
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
      other: 'settori',
      two: 'settori',
      one: 'settore',
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
      other: 'dei settori',
      two: 'dei settori',
      one: 'un settore',
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
      other: 'i settori',
      two: 'i settori',
      one: 'il settore',
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
      other: 'ai settori',
      two: 'ai settori',
      one: 'al settore',
    );
    return '$_temp0';
  }

  @override
  String emptyDataPlaceholder(Object name) {
    return 'Non risulta alcun $name nel database';
  }

  @override
  String get addNewButtonLabel => 'Aggiungi';

  @override
  String nSelectedPumps(num n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n pompe selezionate',
      one: '1 pompa selezionata',
      zero: '0 pompe selezionate',
    );
    return '$_temp0';
  }

  @override
  String nConnectedPumps(num n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n pumps collegate',
      one: '1 pump collegata',
      zero: '0 pompe collegate',
    );
    return '$_temp0';
  }

  @override
  String get connectPumpsToSectorPageTile => 'Seleziona Pompe';

  @override
  String get noPumpConnectedToSectorErrorText => 'Devi collegare almeno una pompa a questo settore';

  @override
  String get pumpLastDispensationForTile => 'Ultima Erogazione';

  @override
  String get pumpLastDispensationEmpty => 'Mai accesa';

  @override
  String get pumpTotalDispensedLitres => 'Litri erogati nel tempo';

  @override
  String nCollectors(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'collettori',
      two: 'collettori',
      one: 'collettore',
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
      other: 'dei collettori',
      two: 'dei collettori',
      one: 'un collettore',
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
      other: 'i collettori',
      two: 'i collettori',
      one: 'il collettore',
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
      other: 'ai collettori',
      two: 'ai collettori',
      one: 'al collettore',
    );
    return '$_temp0';
  }

  @override
  String get addNewCollectorPageTitle => 'Nuovo Collettore';

  @override
  String get updateCollectorPageTitle => 'Aggiorna Collettore';

  @override
  String get collectorName => 'Nome Collettore';

  @override
  String get collectorNameHintText => 'eg: Collettore Giardino';

  @override
  String get collectorFilterName => 'Nome Filtro';

  @override
  String get collectorFilterNameHintText => 'eg: Filtro 1';

  @override
  String nSelectedSectors(num n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n settori selezionati',
      one: '1 settore selezionato',
      zero: '0 settori selezionati',
    );
    return '$_temp0';
  }

  @override
  String get connectSectorToCollectorPageTitle => 'Seleziona Settori';

  @override
  String get collectorConnectedSectors => 'Settori Collegati';

  @override
  String get noSectorConnectedToCollectorErrorText => 'Devi collegare almeno un settore a questo collettore';

  @override
  String get genericConfirmButtonLabel => 'Conferma';

  @override
  String get allSectorsAreConnectedToACollector => 'Tutti i settori sono stati già collegati a un collettore';

  @override
  String nConnectedSectors(num n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n settori collegati',
      one: '1 settore collegato',
      zero: '0 settori collegati',
    );
    return '$_temp0';
  }

  @override
  String get batteryLevel => 'Battery:';

  @override
  String get filterPressureDifference => 'Diff filtri:';

  @override
  String get iotBoardsMenuTitle => 'Centraline';

  @override
  String get settingsMenuTitle => 'Impostazioni';

  @override
  String get profilePageTitle => 'Il mio profilo';

  @override
  String get logOutButtonTitle => 'Esci';

  @override
  String get logOutAlertDialogTitle => 'Sei sicuro di voler uscire dall\'applicazione?';

  @override
  String get logOutAlertDialogContent => 'Cliccando su \'Logout\' verrai disconnesso dall\'applicazione';

  @override
  String get logOutAlertDialogConfirm => 'Esci';

  @override
  String nBoards(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'centraline',
      two: 'centraline',
      one: 'centralina',
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
      other: 'delle centraline',
      two: 'delle centraline',
      one: 'una centralina',
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
      other: 'le centraline',
      two: 'le centraline',
      one: 'la centralina',
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
      other: 'alle centraline',
      two: 'alle centraline',
      one: 'alla centralina',
    );
    return '$_temp0';
  }

  @override
  String get addNewBoardPageTitle => 'Nuova Centralina';

  @override
  String get updateBoardPageTitle => 'Aggiorna Centralina';

  @override
  String get boardName => 'Nome Centralina';

  @override
  String get boardNameHintText => 'eg: arduino mkr16';

  @override
  String get boardModel => 'Modello';

  @override
  String get boardModelHintText => 'eg: MKR 1010';

  @override
  String get boardSerialNumber => 'Numero di Serie';

  @override
  String get boardSerialNumberHintText => 'eg: 123456789';

  @override
  String get boardConnectedCollector => 'Collettore Collegato';

  @override
  String get boardConnectedCollectorHintText => 'Seleziona un collettore';

  @override
  String get allCollectorsAreConnectedToABoard => 'Tutti i collettori sono stati già collegati a una centralina';

  @override
  String get connectCollectorToBoardPageTitle => 'Seleziona un collettore';

  @override
  String nSelectedCollectors(num n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n collettori selezionati',
      one: '1 collettore selezionato',
      zero: '0 collettori selezionati',
    );
    return '$_temp0';
  }

  @override
  String get noCollectorConnectedToBoardErrorText => 'Devi collegare almeno un collettore a questa centralina';

  @override
  String get userProfileDetailsName => 'Nome';

  @override
  String get userProfileDetailsEmail => 'Indirizzo email';

  @override
  String get userProfileDetailsCurrentCompany => 'Profilo aziendale attuale';

  @override
  String get companyProfileMenuTitle => 'Profilo Aziendale';

  @override
  String get companyUsersMenuTitle => 'Utenti Aziendali';

  @override
  String get companyName => 'Nome Azienda';

  @override
  String get companyNameHintText => 'eg: azienda agricola esempio srl';

  @override
  String get companyRegisteredAddress => 'Sede Legale';

  @override
  String get companyRegisteredAddressHintText => 'eg: via roma 1, 00100, roma';

  @override
  String get companyVatNumber => 'Partita IVA';

  @override
  String get companyVatNumberHintText => 'eg: 123456789';

  @override
  String get companyFiscalCode => 'Codice Fiscale';

  @override
  String get companyFiscalCodeHintText => 'eg: 123456789';

  @override
  String get companyEmail => 'Indirizzo email aziendale';

  @override
  String get companyEmailHintText => 'eg: email@company.com';

  @override
  String get companyPhone => 'Telefono Aziendale';

  @override
  String get companyPhoneHintText => 'eg: +123456789';

  @override
  String dependentFieldsEmptyErrorText(Object firstFieldName, Object secondFieldName) {
    return 'Uno tra $firstFieldName e $secondFieldName deve essere compilato';
  }

  @override
  String get addNewCompanyPageTitle => 'Nuova Azienda';

  @override
  String get updateCompanyPageTitle => 'Aggiorna Azienda';

  @override
  String nCompany(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'aziende',
      two: 'aziende',
      one: 'azienda',
    );
    return '$_temp0';
  }

  @override
  String get noUsersConnectedWithCompany => 'Non ci sono utenti associati a questa azienda';

  @override
  String get companyUserFullName => 'Nome e cognome';

  @override
  String get companyUserFullNameHintTest => 'eg: Francesco Rossi';

  @override
  String get companyUserEmail => 'Indirizzo email';

  @override
  String get companyUserEmailHintText => 'eg: example@example.com';

  @override
  String get companyUserRole => 'Assegna un ruolo';

  @override
  String get companyUserRoleHintText => 'Seleziona un ruolo';

  @override
  String get companyUserAssignedRoleForDetails => 'Ruolo assegnato';

  @override
  String get companyUserAddedOn => 'Aggiunto il';

  @override
  String get companyUserLastUpdated => 'Ultimo aggiornamento';

  @override
  String get addNewCompanyUserPageTitle => 'Nuovo Utente Aziendale';

  @override
  String get updateCompanyUserPageTitle => 'Aggiorna Utente Aziendale';

  @override
  String get emailAlreadyInUseErrorText => 'Questo indirizzo email è già in uso';

  @override
  String nCompanyUsers(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'utenti aziendali',
      two: 'utenti aziendali',
      one: 'utente aziendale',
    );
    return '$_temp0';
  }

  @override
  String get assignRoleDialogTitle => 'Assegna un ruolo';

  @override
  String get me => 'Io';

  @override
  String get companyUserDismissalDialogTitle => 'Sei sicuro di voler eliminare questo utente?';

  @override
  String companyUserDismissalDialogContent(Object companyUserName) {
    return 'Stai per eliminare $companyUserName come utente';
  }

  @override
  String get cantDeleteYourselfDialogTitle => 'Non puoi eliminare te stesso come utente';

  @override
  String get noUppercaseInPasswordErrorText => 'La password deve contenere almeno una lettera maiuscola';

  @override
  String get noLowercaseInPasswordErrorText => 'La password deve contenere almeno una lettera minuscola';

  @override
  String get noNumberInPasswordErrorText => 'La password deve contenere almeno un numero';

  @override
  String get noSpecialCharacterInPasswordErrorText => 'La password deve contenere almeno un carattere speciale';

  @override
  String get passwordsDoNotMatchErrorText => 'Le password non corrispondono';

  @override
  String get invalidCredentialsErrorText => 'La password o l\'indirizzo email inseriti non sono corretti';

  @override
  String get introductorySignInText => 'Accedi con le tue credenziali per continuare';

  @override
  String get noAccountText => 'Non hai un account?';

  @override
  String get signUpText => 'Registrati';

  @override
  String get signUpButtonTitle => 'Registrati';

  @override
  String get confirmPasswordFormFieldTitle => 'Conferma Password';

  @override
  String get confirmPasswordFormHint => '••••••••';

  @override
  String get alreadyHaveAnAccountText => 'Hai già un account?';

  @override
  String get nameFormFieldTitle => 'Nome';

  @override
  String get nameFormHint => 'Mario';

  @override
  String get surnameFormFieldTitle => 'Cognome';

  @override
  String get surnameFormHint => 'Rossi';

  @override
  String get signInPageIntroductoryTitleText => 'Benvenuto!';

  @override
  String get signUpPageIntroductoryTitleText => 'Inizia con noi!';

  @override
  String get signUpPageIntroductorySubtitleText => 'Crea il tuo account';

  @override
  String get signInPageIntroductorySubtitleText => 'Accedi al tuo account';
}
