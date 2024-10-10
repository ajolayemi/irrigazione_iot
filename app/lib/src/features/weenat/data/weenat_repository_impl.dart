
import 'package:dio/dio.dart';
import 'package:irrigazione_iot/src/features/weenat/data/weenat_repository.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_auth_payload.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_auth_res_data.dart';

class WeenatRepositoryImpl implements WeenatRepository {
  static final _dioOptions = BaseOptions(
    baseUrl: "https://api-prod.weenat.com/api",
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  );

  final _dio = Dio(_dioOptions);

  @override
  Future<String?> authWeenat({
    required WeenatAuthPayload payload,
  }) async {
    try {
      final res = await _dio.post(
        '/api-token-auth/',
        data: payload.toJson(),
      );
      final resData = res.data as Map<String, dynamic>;
      return WeenatAuthResData.fromJson(resData).token;
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
  Future<void> getPlots() {
    // TODO: implement getPlots
    throw UnimplementedError();
  }
}
