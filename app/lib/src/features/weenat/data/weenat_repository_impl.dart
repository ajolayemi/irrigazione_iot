import 'package:irrigazione_iot/src/data/repositories/http_repo/http_repository.dart';
import 'package:irrigazione_iot/src/features/weenat/data/weenat_repository.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_auth_payload.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_auth_res_data.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot.dart';

// TODO: properly handle exceptions
class WeenatRepositoryImpl extends HttpRepository implements WeenatRepository {
  WeenatRepositoryImpl(String baseUrl) : super(baseUrl: baseUrl);

  @override
  Future<String?> authWeenat({
    required WeenatAuthPayload payload,
  }) async {
    try {
      final res = await post(
        path: '/api-token-auth/',
        data: payload.toJson(),
      );
      final data = res.data as Map<String, dynamic>;
      return WeenatAuthResData.fromJson(data).token;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> getMeasures({
    required String plotId,
    required DateTime from,
    required DateTime to,
  }) {
    // TODO: implement getMeasures
    throw UnimplementedError();
  }

  @override
  Future<List<WeenatPlot>?> getPlots({
    required String token,
  }) async {
    try {
      final headers = {
        HttpHeaders.contentType: HttpHeaders.json,
        HttpHeaders.authorization: '${HttpHeaders.bearer} $token',
      };
      final res = await get(
        path: '/v2/access/plots/',
        headers: headers,
      );
      final data = res.data as List<dynamic>;
      final plots = data.map((e) => WeenatPlot.fromJson(e)).toList();
      return plots;
    } catch (_) {
      rethrow;
    }
  }
}
