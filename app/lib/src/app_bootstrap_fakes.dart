import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/app_bootstrap.dart';
import 'package:irrigazione_iot/src/exceptions/async_error_logger.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/data/fake_auth_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_status_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/fake_board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/fake_board_status_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/fake_collector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/data/fake_collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/fake_company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/fake_company_users_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_flow_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/fake_sector_pumps_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/fake_sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/fake_sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/settings/settings_controller.dart';

/// Extension methods specific for "fakes" project configuration
extension AppBootstrapFakes on AppBootstrap {
  /// Creates the top-level [ProviderContainer] by overriding providers with fake
  /// repositories only. This is useful for testing purposes and for running the
  /// app with a "fake" backend.
  ///
  /// Note: all repositories needed by the app can be accessed via providers.
  /// Some of these providers throw an [UnimplementedError] by default.
  ///
  /// Example:
  /// ```dart
  ///@riverpod
  /// SettingsController settingsController(settingsControllerRef) {
  ///   throw UnimplementedError();
  /// }
  /// ```
  ///
  /// As a result, this method does two things:
  /// - create and configure the repositories as desired
  /// - override the default implementations with a list of "overrides"
  Future<ProviderContainer> createFakesProviderContainer(
      {bool addDelay = true}) async {
    final settingsController = await bootSettingsController();
    final authRepository = FakeAuthRepository(addDelay: addDelay);
    final boardRepository = FakeBoardRepository(addDelay: addDelay);
    final boardStatusRepository = FakeBoardStatusRepository(addDelay: addDelay);
    final collectorPressureRepository =
        FakeCollectorPressureRepository(addDelay: addDelay);
    final collectorSectorRepository =
        FakeCollectorSectorRepository(addDelay: addDelay);
    final companyRepository = FakeCompanyRepository(addDelay: addDelay);
    final companyUserRepository =
        FakeCompanyUsersRepository(addDelay: addDelay);
    final pumpRepository = FakePumpRepository(addDelay: addDelay);
    final pumpFlowRepository = FakePumpFlowRepository(addDelay: addDelay);
    final pumpStatusRepository = FakePumpStatusRepository(addDelay: addDelay);
    final sectorRepository = FakeSectorRepository(addDelay: addDelay);
    final sectorStatusRepository = FakeSectorStatusRepository(addDelay: addDelay);
    final sectorPumpRepository = FakeSectorPumpRepository(addDelay: addDelay);
    return ProviderContainer(
      overrides: [
        // repositories
        authRepositoryProvider.overrideWithValue(authRepository),
        boardRepositoryProvider.overrideWithValue(boardRepository),
        boardStatusRepositoryProvider.overrideWithValue(boardStatusRepository),
        collectorPressureRepositoryProvider
            .overrideWithValue(collectorPressureRepository),
        collectorSectorRepositoryProvider
            .overrideWithValue(collectorSectorRepository),
        companyRepositoryProvider.overrideWithValue(companyRepository),
        companyUsersRepositoryProvider.overrideWithValue(companyUserRepository),
        pumpRepositoryProvider.overrideWithValue(pumpRepository),
        pumpFlowRepositoryProvider.overrideWithValue(pumpFlowRepository),
        pumpStatusRepositoryProvider.overrideWithValue(pumpStatusRepository),
        sectorRepositoryProvider.overrideWithValue(sectorRepository),
        sectorStatusRepositoryProvider.overrideWithValue(sectorStatusRepository),
        sectorPumpRepositoryProvider.overrideWithValue(sectorPumpRepository),
        // services
        settingsControllerProvider.overrideWithValue(settingsController),
      ],
      observers: [
        AsyncErrorLogger(),
      ],
    );
  }
}
