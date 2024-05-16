import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/features/welcome/screens/welcome_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/config/routes/go_router_refresh_stream.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/config/routes/service/router_redirect_service.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/screens/sign_in/sign_in_screen.dart';
import 'package:irrigazione_iot/src/features/authentication/screens/sign_up/sign_up_screen.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screens/add_update_boards/add_update_boards_form.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screens/add_update_boards/connect_collector_to_board_screen.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screens/board_details/board_details_screen.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screens/boards_list/boards_list_screen.dart';
import 'package:irrigazione_iot/src/features/collectors/screens/add_update_collector/add_update_collector_form.dart';
import 'package:irrigazione_iot/src/features/collectors/screens/add_update_collector/connect_sectors_to_collector_screen.dart';
import 'package:irrigazione_iot/src/features/collectors/screens/collector_details/collector_details.dart';
import 'package:irrigazione_iot/src/features/collectors/screens/collector_list_screen.dart';
import 'package:irrigazione_iot/src/features/company_profile/screens/add_update_company_form.dart';
import 'package:irrigazione_iot/src/features/company_profile/screens/company_profile_screen.dart';
import 'package:irrigazione_iot/src/features/company_users/screens/add_update_company_user/add_update_company_user_form.dart';
import 'package:irrigazione_iot/src/features/company_users/screens/company_user_details/company_user_details_screen.dart';
import 'package:irrigazione_iot/src/features/company_users/screens/company_users_list/company_users_list_screen.dart';
import 'package:irrigazione_iot/src/features/company_users/screens/user_company_list/user_companies_list_screen.dart';
import 'package:irrigazione_iot/src/features/dashboard/screens/dashboard_screen.dart';
import 'package:irrigazione_iot/src/features/home/screens/home_nested_navigator.dart';
import 'package:irrigazione_iot/src/features/more/screens/more_options_screen.dart';
import 'package:irrigazione_iot/src/features/pumps/screens/add_pump/add_update_pump_form.dart';
import 'package:irrigazione_iot/src/features/pumps/screens/pump_details/pump_details_screen.dart';
import 'package:irrigazione_iot/src/features/pumps/screens/pump_list/pumps_list_screen.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/add_update_sector/add_update_sector_form.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/add_update_sector/connect_pumps_to_sector_screen.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/add_update_sector/select_a_specie_screen.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/add_update_sector/select_a_variety_screen.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/add_update_sector/select_an_irrigation_source.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/add_update_sector/select_an_irrigation_system.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_details/sector_details.dart';
import 'package:irrigazione_iot/src/features/sectors/screens/sector_list/sectors_list_screen.dart';
import 'package:irrigazione_iot/src/features/weather_stations/screens/add_update_sensor/add_update_sensor_form.dart';
import 'package:irrigazione_iot/src/features/weather_stations/screens/add_update_sensor/connect_sector_to_sensor_screen.dart';
import 'package:irrigazione_iot/src/features/weather_stations/screens/sensor_details/sensor_details_screen.dart';
import 'package:irrigazione_iot/src/features/weather_stations/screens/sensor_list/sensors_list_screen.dart';
import 'package:irrigazione_iot/src/features/weather_stations/screens/sensor_stat_history/sensor_statistic_history_screen.dart';
import 'package:irrigazione_iot/src/features/user_profile/screens/user_profile_screen.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/utils/extensions/go_router_extension.dart';

part 'app_router.g.dart';

// private navigator keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _dashboardShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'Dashboard');

final _collectorShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'Collector');
final _pumpShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Pump');
final _sectorShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'Sector');
final _moreShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'More');

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final routerService = ref.read(routerRedirectServiceProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: AppRoute.welcome.path,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,

    // * redirect logic based on the authentication state
    redirect: routerService.redirect,
    refreshListenable: GoRouterRefreshStream(
      authRepository.authStateChanges(),
    ),
    routes: [
      GoRoute(
        path: AppRoute.welcome.path,
        name: AppRoute.welcome.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: WelcomeScreen(),
        ),
      ),
      GoRoute(
        path: AppRoute.registerCompany.path,
        name: AppRoute.registerCompany.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: AddUpdateCompanyForm(
            formType: GenericFormTypes.add,
          ),
        ),
      ),
      GoRoute(
        path: AppRoute.signIn.path,
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => const MaterialPage(
          child: SignInScreen(),
          fullscreenDialog: true,
        ),
      ),
      GoRoute(
        path: AppRoute.signUp.path,
        name: AppRoute.signUp.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: SignUpScreen(),
        ),
      ),

      GoRoute(
        path: AppRoute.companiesListGrid.path,
        name: AppRoute.companiesListGrid.name,
        pageBuilder: (context, state) => const MaterialPage(
          child: UserCompaniesListScreen(),
          fullscreenDialog: true,
        ),
      ),
      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          // The dashboard branch which also serves as the app's home screen
          StatefulShellBranch(
            navigatorKey: _dashboardShellNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.home.path,
                name: AppRoute.home.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: DashboardScreen(),
                ),
              ),
            ],
          ),

          // Collector branch
          StatefulShellBranch(
            navigatorKey: _collectorShellNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.collector.path,
                name: AppRoute.collector.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CollectorListScreen(),
                ),
                routes: [
                  GoRoute(
                    path: AppRoute.collectorDetails.path,
                    name: AppRoute.collectorDetails.name,
                    pageBuilder: (context, state) {
                      return MaterialPage(
                        fullscreenDialog: true,
                        child: CollectorDetailsScreen(
                          collectorId: state.pathId,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // Pump branch
          StatefulShellBranch(
            navigatorKey: _pumpShellNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.pump.path,
                name: AppRoute.pump.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PumpListScreen(),
                ),
                routes: [
                  GoRoute(
                      path: AppRoute.pumpDetails.path,
                      name: AppRoute.pumpDetails.name,
                      pageBuilder: (context, state) {
                        return MaterialPage(
                          fullscreenDialog: true,
                          child: PumpDetailsScreen(
                            pumpId: state.pathId,
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),

          // Meteo branch
          StatefulShellBranch(
            navigatorKey: _sectorShellNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.sector.path,
                name: AppRoute.sector.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SectorsListScreen(),
                ),
                routes: [
                  // Sector details
                  GoRoute(
                      path: AppRoute.sectorDetails.path,
                      name: AppRoute.sectorDetails.name,
                      pageBuilder: (context, state) {
                        return MaterialPage(
                          fullscreenDialog: true,
                          child: SectorDetailsScreen(
                            sectorID: state.pathId,
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),

          // More branch
          StatefulShellBranch(
            navigatorKey: _moreShellNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.more.path,
                name: AppRoute.more.name,
                pageBuilder: (context, state) => const MaterialPage(
                  fullscreenDialog: true,
                  child: MoreOptionsScreen(),
                ),
              ),
            ],
          ),
        ],
      ),

      // Add new pump
      GoRoute(
        path: AppRoute.addPump.path,
        name: AppRoute.addPump.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: AddUpdatePumpForm(
            formType: GenericFormTypes.add,
          ),
        ),
      ),

      GoRoute(
          path: AppRoute.updatePump.path,
          name: AppRoute.updatePump.name,
          pageBuilder: (context, state) {
            return MaterialPage(
              fullscreenDialog: true,
              child: AddUpdatePumpForm(
                formType: GenericFormTypes.update,
                pumpId: state.pathId,
              ),
            );
          }),

      // Add sector
      GoRoute(
        path: AppRoute.addSector.path,
        name: AppRoute.addSector.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: AddUpdateSectorForm(
            formType: GenericFormTypes.add,
          ),
        ),
      ),

      // Update sector
      GoRoute(
          path: AppRoute.updateSector.path,
          name: AppRoute.updateSector.name,
          pageBuilder: (context, state) {
            return MaterialPage(
              fullscreenDialog: true,
              child: AddUpdateSectorForm(
                formType: GenericFormTypes.update,
                sectorId: state.pathId,
              ),
            );
          }),

      // Select a specie
      GoRoute(
        path: AppRoute.selectASpecie.path,
        name: AppRoute.selectASpecie.name,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SelectASpecieScreen(
              selectedSpecieId: state.queryId,
              selectedSpecieName: state.queryName,
            ),
            fullscreenDialog: true,
          );
        },
      ),

      // Select a variety
      GoRoute(
        path: AppRoute.selectAVariety.path,
        name: AppRoute.selectAVariety.name,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SelectAVarietyScreen(
              selectedVarietyId: state.queryId,
              selectedVarietyName: state.queryName,
            ),
            fullscreenDialog: true,
          );
        },
      ),

      // Select an irrigation system
      GoRoute(
        path: AppRoute.selectAnIrrigationSystem.path,
        name: AppRoute.selectAnIrrigationSystem.name,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SelectAnIrrigationSystem(
              selectedIrrigationSystem: state.queryName,
            ),
            fullscreenDialog: true,
          );
        },
      ),

      // Select an irrigation source
      GoRoute(
        path: AppRoute.selectAnIrrigationSource.path,
        name: AppRoute.selectAnIrrigationSource.name,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SelectAnIrrigationSource(
              selectedIrrigationSource: state.queryName,
            ),
            fullscreenDialog: true,
          );
        },
      ),

      // Connect pumps to sector
      GoRoute(
        path: AppRoute.connectPumpToSector.path,
        name: AppRoute.connectPumpToSector.name,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ConnectPumpToSector(
              selectedPumpId: state.queryId,
              selectedPumpName: state.queryName,
              pumpIdPreviouslyConnectedToSector:
                  state.queryPreviouslyConnectedId,
            ),
            fullscreenDialog: true,
          );
        },
      ),

      // Page to display form for adding a new collector
      GoRoute(
        path: AppRoute.addCollector.path,
        name: AppRoute.addCollector.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: AddUpdateCollectorForm(
            formType: GenericFormTypes.add,
          ),
        ),
      ),

      // Page to display form for updating a collector
      GoRoute(
          path: AppRoute.updateCollector.path,
          name: AppRoute.updateCollector.name,
          pageBuilder: (context, state) {
            return MaterialPage(
              fullscreenDialog: true,
              child: AddUpdateCollectorForm(
                formType: GenericFormTypes.update,
                collectorId: state.pathId,
              ),
            );
          }),

      // Page to display when user wants to connect sectors to a collector
      GoRoute(
        path: AppRoute.connectSectorToCollector.path,
        name: AppRoute.connectSectorToCollector.name,
        pageBuilder: (context, state) {
          return MaterialPage(
            fullscreenDialog: true,
            child: ConnectSectorsToCollector(
              idOfCollectorBeingEdited: state.queryId,
            ),
          );
        },
      ),

      /// Board (centraline) routes and it's sub-routes
      GoRoute(
        path: AppRoute.boards.path,
        name: AppRoute.boards.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: BoardsListScreen(),
        ),
        routes: [
          GoRoute(
              path: AppRoute.boardDetails.path,
              name: AppRoute.boardDetails.name,
              pageBuilder: (context, state) {
                return MaterialPage(
                  fullscreenDialog: true,
                  child: BoardDetailsScreen(
                    boardID: state.pathId,
                  ),
                );
              }),
          GoRoute(
            path: AppRoute.addBoard.path,
            name: AppRoute.addBoard.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: AddUpdateBoardsForm(formType: GenericFormTypes.add),
            ),
          ),
          GoRoute(
              path: AppRoute.updateBoard.path,
              name: AppRoute.updateBoard.name,
              pageBuilder: (context, state) {
                return MaterialPage(
                  fullscreenDialog: true,
                  child: AddUpdateBoardsForm(
                    formType: GenericFormTypes.update,
                    boardID: state.pathId,
                  ),
                );
              }),
          GoRoute(
            path: AppRoute.connectCollectorToBoard.path,
            name: AppRoute.connectCollectorToBoard.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                child: ConnectCollectorToBoardScreen(
                  previouslyConnectedCollectorId:
                      state.queryPreviouslyConnectedId,
                  selectedCollectorId: state.queryId,
                  selectedCollectorName: state.queryName,
                ),
                fullscreenDialog: true,
              );
            },
          ),
        ],
      ),

      // My profile route
      GoRoute(
        path: AppRoute.profile.path,
        name: AppRoute.profile.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: UserProfileScreen(),
        ),
      ),

      // Company profile route and sub-route to edit the company profile
      GoRoute(
        path: AppRoute.companyProfile.path,
        name: AppRoute.companyProfile.name,
        pageBuilder: (context, state) {
          return MaterialPage(
            fullscreenDialog: true,
            child: CompanyProfileScreen(
              companyID: state.pathId,
            ),
          );
        },
        routes: [
          GoRoute(
            path: AppRoute.updateCompany.path,
            name: AppRoute.updateCompany.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                fullscreenDialog: true,
                child: AddUpdateCompanyForm(
                  companyID: state.pathId,
                  formType: GenericFormTypes.update,
                ),
              );
            },
          ),
        ],
      ),

      // Route to view the list of users for the company and
      // sub-route to edit and add new users
      GoRoute(
        path: AppRoute.companyUsers.path,
        name: AppRoute.companyUsers.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: CompanyUsersListScreen(),
        ),
        routes: [
          GoRoute(
            path: AppRoute.addCompanyUser.path,
            name: AppRoute.addCompanyUser.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: AddUpdateCompanyUserForm(
                companyUserId: '',
                formType: GenericFormTypes.add,
              ),
            ),
          ),
          GoRoute(
            path: AppRoute.companyUserDetails.path,
            name: AppRoute.companyUserDetails.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                fullscreenDialog: true,
                child: CompanyUserDetailsScreen(
                  companyUserId: state.pathId,
                ),
              );
            },
            routes: [
              GoRoute(
                path: AppRoute.updateCompanyUser.path,
                name: AppRoute.updateCompanyUser.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    fullscreenDialog: true,
                    child: AddUpdateCompanyUserForm(
                      companyUserId: state.pathId,
                      formType: GenericFormTypes.update,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),

      // Sensors and its sub-routes
      GoRoute(
        path: AppRoute.sensors.path,
        name: AppRoute.sensors.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: SensorsListScreen(),
        ),
        routes: [
          GoRoute(
            path: AppRoute.addSensor.path,
            name: AppRoute.addSensor.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: AddUpdateSensorForm(
                formType: GenericFormTypes.add,
              ),
            ),
          ),
          GoRoute(
              path: AppRoute.sensorDetails.path,
              name: AppRoute.sensorDetails.name,
              pageBuilder: (context, state) {
                final pathParam = PathParameters.fromJson(state.pathParameters);
                return MaterialPage(
                  fullscreenDialog: true,
                  child: SensorDetailsScreen(
                    sensorId: pathParam.id,
                  ),
                );
              },
              routes: [
                GoRoute(
                    path: AppRoute.sensorStatisticHistory.path,
                    name: AppRoute.sensorStatisticHistory.name,
                    pageBuilder: (context, state) {
                      return MaterialPage(
                        fullscreenDialog: true,
                        child: SensorStatisticHistoryScreen(
                          columnName: state.historyQueryColName,
                          statisticName: state.historyQueryStatisticName,
                          sensorId: state.pathId,
                        ),
                      );
                    })
              ]),
          GoRoute(
            path: AppRoute.updateSensor.path,
            name: AppRoute.updateSensor.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                fullscreenDialog: true,
                child: AddUpdateSensorForm(
                  formType: GenericFormTypes.update,
                  sensorId: state.pathId,
                ),
              );
            },
          ),
          GoRoute(
            path: AppRoute.connectSectorToSensor.path,
            name: AppRoute.connectSectorToSensor.name,
            pageBuilder: (context, state) {
              final selectedSector = RadioButtonItem(
                value: state.queryId ?? '',
                label: state.queryName ?? '',
              );
              return MaterialPage(
                child: ConnectSectorToSensorScreen(
                  selectedSector: selectedSector,
                ),
                fullscreenDialog: true,
              );
            },
          ),
        ],
      ),
    ],
  );
}
