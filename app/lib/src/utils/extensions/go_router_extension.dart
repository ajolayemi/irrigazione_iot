import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';

extension GoRouterStateX on GoRouterState {

  PathParameters get toPathParams => PathParameters.fromJson(pathParameters);

  // Gets the "id" parameter from the path parameters.
  String get pathId => toPathParams.id;
}