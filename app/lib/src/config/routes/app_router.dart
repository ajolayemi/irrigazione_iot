import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/shared/models/query_params.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/config/enums/form_types.dart';
import 'package:irrigazione_iot/src/config/routes/go_router_refresh_stream.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/screen/sign_in/sign_in_screen.dart';
import 'package:irrigazione_iot/src/features/authentication/screen/sign_up/sign_up_screen.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screen/add_update_boards/add_update_boards_form.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screen/add_update_boards/connect_collector_to_board_screen.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screen/board_details/board_details_screen.dart';
import 'package:irrigazione_iot/src/features/board-centraline/screen/boards_list/boards_list_screen.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/add_update_collector/add_update_collector_form.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/add_update_collector/connect_sectors_to_collector_screen.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/collector_details/collector_details.dart';
import 'package:irrigazione_iot/src/features/collectors/screen/collector_list_screen.dart';
import 'package:irrigazione_iot/src/features/company_profile/screen/add_update_company_form.dart';
import 'package:irrigazione_iot/src/features/company_profile/screen/company_profile_screen.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/screen/add_update_company_user/add_update_company_user_form.dart';
import 'package:irrigazione_iot/src/features/company_users/screen/company_user_details/company_user_details_screen.dart';
import 'package:irrigazione_iot/src/features/company_users/screen/company_users_list/company_users_list_screen.dart';
import 'package:irrigazione_iot/src/features/company_users/screen/user_company_list/user_companies_list_screen.dart';
import 'package:irrigazione_iot/src/features/dashboard/screen/dashboard_screen.dart';
import 'package:irrigazione_iot/src/features/home/screen/home_nested_navigator.dart';
import 'package:irrigazione_iot/src/features/more/screen/more_options_screen.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/add_pump/add_update_pump_form.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_details/pump_details_screen.dart';
import 'package:irrigazione_iot/src/features/pumps/screen/pump_list/pumps_list_screen.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/add_update_sector_form.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/connect_pumps_to_sector_screen.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/select_a_specie_screen.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/select_an_irrigation_source.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/add_update_sector/select_an_irrigation_system.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_details/sector_details.dart';
import 'package:irrigazione_iot/src/features/sectors/screen/sector_list/sectors_list_screen.dart';
import 'package:irrigazione_iot/src/features/user_profile/screen/user_profile_screen.dart';

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
  final authRepository = ref.watch(authRepositoryProvider);
  final initialTappedCompanyRepo = ref.watch(selectedCompanyRepositoryProvider);
  return GoRouter(
    initialLocation: '/sign-in',
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,

    // * redirect logic based on the authentication state
    redirect: (context, state) {
      final user = authRepository.currentUser;
      final isLoggedIn = user != null;
      final path = state.uri.path;
      //final isLoginOrSign
      if (isLoggedIn && path == '/sign-in') {
        final userHasAlreadySelectedACompany =
            initialTappedCompanyRepo.loadSelectedCompanyId(user.uid) != null;

        if (userHasAlreadySelectedACompany) {
          return '/';
        }
        return '/companies-list-grid';
      }
      if (!isLoggedIn && path != '/sign-in') {
        // if user is trying to access sign-up page, let them
        if (path == '/sign-up') {
          return null;
        }
        return '/sign-in'; // redirect to sign in page if user is not logged in
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(
      authRepository.authStateChanges(),
    ),
    routes: [
      GoRoute(
        path: '/sign-in',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SignInScreen()),
      ),

      GoRoute(
        path: '/sign-up',
        name: AppRoute.signUp.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SignUpScreen()),
      ),
      GoRoute(
        path: '/companies-list-grid',
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
                path: '/',
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
                path: '/collector',
                name: AppRoute.collector.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CollectorListScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'details/:collectorId',
                    name: AppRoute.collectorDetails.name,
                    pageBuilder: (context, state) => MaterialPage(
                      fullscreenDialog: true,
                      child: CollectorDetailsScreen(
                        collectorId: state.pathParameters['collectorId'] ?? '',
                      ),
                    ),
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
                path: '/pump',
                name: AppRoute.pump.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: PumpListScreen()),
                routes: [
                  GoRoute(
                    path: 'details/:pumpId',
                    name: AppRoute.pumpDetails.name,
                    pageBuilder: (context, state) => MaterialPage(
                      fullscreenDialog: true,
                      child: PumpDetailsScreen(
                        pumpId: state.pathParameters['pumpId'] ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Meteo branch
          StatefulShellBranch(
            navigatorKey: _sectorShellNavigatorKey,
            routes: [
              GoRoute(
                path: '/sector',
                name: AppRoute.sector.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SectorsListScreen(),
                ),
                routes: [
                  // Sector details
                  GoRoute(
                    path: 'details/:sectorId',
                    name: AppRoute.sectorDetails.name,
                    pageBuilder: (context, state) => MaterialPage(
                      fullscreenDialog: true,
                      child: SectorDetailsScreen(
                        sectorID: state.pathParameters['sectorId'] ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // More branch
          StatefulShellBranch(
            navigatorKey: _moreShellNavigatorKey,
            routes: [
              GoRoute(
                path: '/more',
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
        path: '/add-pump',
        name: AppRoute.addPump.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: AddUpdatePumpForm(
            formType: GenericFormTypes.add,
          ),
        ),
      ),

      GoRoute(
        path: '/pump/edit/:pumpId',
        name: AppRoute.updatePump.name,
        pageBuilder: (context, state) => MaterialPage(
          fullscreenDialog: true,
          child: AddUpdatePumpForm(
            formType: GenericFormTypes.update,
            pumpId: state.pathParameters['pumpId'] ?? '',
          ),
        ),
      ),

      // Add sector
      GoRoute(
        path: '/add-sector',
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
        path: '/sector/edit/:sectorId',
        name: AppRoute.updateSector.name,
        pageBuilder: (context, state) => MaterialPage(
          fullscreenDialog: true,
          child: AddUpdateSectorForm(
            formType: GenericFormTypes.update,
            sectorId: state.pathParameters['sectorId'] ?? '',
          ),
        ),
      ),

      // Select a specie
      GoRoute(
        path: '/select-a-specie',
        name: AppRoute.selectASpecie.name,
        pageBuilder: (context, state) {
          final queryParams =
              QueryParameters.fromJson(state.uri.queryParameters);
          return MaterialPage(
            child: SelectASpecieScreen(
              selectedSpecieId: queryParams.id,
              selectedSpecieName: queryParams.name,
            ),
            fullscreenDialog: true,
          );
        },
      ),

      // Select an irrigation system
      GoRoute(
        path: '/select-an-irrigation-system',
        name: AppRoute.selectAnIrrigationSystem.name,
        pageBuilder: (context, state) => const MaterialPage(
          child: SelectAnIrrigationSystem(),
          fullscreenDialog: true,
        ),
      ),

      // Select an irrigation source
      GoRoute(
        path: '/select-an-irrigation-source',
        name: AppRoute.selectAnIrrigationSource.name,
        pageBuilder: (context, state) => const MaterialPage(
          child: SelectAnIrrigationSource(),
          fullscreenDialog: true,
        ),
      ),

      // Connect pumps to sector
      GoRoute(
        path: '/connect-pump-to-sector',
        name: AppRoute.connectPumpToSector.name,
        pageBuilder: (context, state) => MaterialPage(
          fullscreenDialog: true,
          child: ConnectPumpToSector(
            pumpIdAlreadyConnected:
                state.uri.queryParameters['pumpIdAlreadyConnected'],
          ),
        ),
      ),

      // Page to display form for adding a new collector
      GoRoute(
        path: '/add-collector',
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
        path: '/collector/edit/:collectorId',
        name: AppRoute.updateCollector.name,
        pageBuilder: (context, state) => MaterialPage(
          fullscreenDialog: true,
          child: AddUpdateCollectorForm(
            formType: GenericFormTypes.update,
            collectorId: state.pathParameters['collectorId'] ?? '',
          ),
        ),
      ),

      // Page to display when user wants to connect sectors to a collector
      GoRoute(
        path: '/connect-sectors-to-collector',
        name: AppRoute.connectSectorToCollector.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: ConnectSectorsToCollector(),
        ),
      ),

      /// Board (centraline) routes and it's sub-routes
      GoRoute(
        path: '/boards',
        name: AppRoute.boards.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: BoardsListScreen(),
        ),
        routes: [
          GoRoute(
            path: 'details/:boardId',
            name: AppRoute.boardDetails.name,
            pageBuilder: (context, state) => MaterialPage(
              fullscreenDialog: true,
              child: BoardDetailsScreen(
                boardID: state.pathParameters['boardId'] ?? '',
              ),
            ),
          ),
          GoRoute(
            path: 'add',
            name: AppRoute.addBoard.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: AddUpdateBoardsForm(formType: GenericFormTypes.add),
            ),
          ),
          GoRoute(
            path: 'edit/:boardId',
            name: AppRoute.updateBoard.name,
            pageBuilder: (context, state) => MaterialPage(
              fullscreenDialog: true,
              child: AddUpdateBoardsForm(
                formType: GenericFormTypes.update,
                boardID: state.pathParameters['boardId'],
              ),
            ),
          ),
          GoRoute(
            path: 'connect-collector',
            name: AppRoute.connectCollectorToBoard.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: ConnectCollectorToBoardScreen(),
            ),
          ),
        ],
      ),

      // My profile route
      GoRoute(
        path: '/profile',
        name: AppRoute.profile.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: UserProfileScreen(),
        ),
      ),

      // Company profile route and sub-route to edit the company profile
      GoRoute(
        path: '/company-profile/:companyID',
        name: AppRoute.companyProfile.name,
        pageBuilder: (context, state) => MaterialPage(
          fullscreenDialog: true,
          child: CompanyProfileScreen(
            companyID: state.pathParameters['companyID'] ?? '',
          ),
        ),
        routes: [
          GoRoute(
            path: 'edit',
            name: AppRoute.updateCompany.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                fullscreenDialog: true,
                child: AddUpdateCompanyForm(
                  companyID: state.pathParameters['companyID'] ?? '',
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
        path: '/company-users',
        name: AppRoute.companyUsers.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: CompanyUsersListScreen(),
        ),
        routes: [
          GoRoute(
            path: 'add',
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
            path: 'details/:companyUserId',
            name: AppRoute.companyUserDetails.name,
            pageBuilder: (context, state) => MaterialPage(
              fullscreenDialog: true,
              child: CompanyUserDetailsScreen(
                companyUserId: state.pathParameters['companyUserId'] ?? '',
              ),
            ),
            routes: [
              GoRoute(
                path: 'edit',
                name: AppRoute.updateCompanyUser.name,
                pageBuilder: (context, state) => MaterialPage(
                  fullscreenDialog: true,
                  child: AddUpdateCompanyUserForm(
                    companyUserId: state.pathParameters['companyUserId'] ?? '',
                    formType: GenericFormTypes.update,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
