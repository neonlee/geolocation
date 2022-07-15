import 'package:cloudwatch/core/routes/named_routes.dart';
import 'package:cloudwatch/infra/http_client.dart';
import 'package:cloudwatch/localization/data/models/current_position_ip_model.dart';
import 'package:cloudwatch/localization/domain/entity/current_position_ip_entity.dart';

abstract class LocalizationRemoteDatasource {
  Future<CurrentPositionByIPEntity> currentPositionByIP({required String ip});
}

class LocalizationRemoteDatasourceImpl extends LocalizationRemoteDatasource {
  final HttpClient _httpClient;

  LocalizationRemoteDatasourceImpl({required HttpClient httpClient})
      : _httpClient = httpClient;
  @override
  Future<CurrentPositionByIPEntity> currentPositionByIP({
    required String ip,
  }) async {
    try {
      var url = NamedRoutes.homePage.replaceAll(':ip', ip);
      var response = await _httpClient.get(url);
      return CurrentPositionByIPModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
