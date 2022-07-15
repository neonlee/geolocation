import 'package:cloudwatch/core/routes/named_routes.dart';
import 'package:cloudwatch/infra/http_client.dart';
import 'package:cloudwatch/localization/data/datasource/localization_remotedatasource.dart';
import 'package:cloudwatch/localization/domain/entity/current_position_ip_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'localization_remote_datasource_test.mocks.dart';

@GenerateMocks([HttpClient])
void main() {
  late LocalizationRemoteDatasource localizationRemoteDatasource;
  late HttpClient httpClient;
  setUp(() {
    httpClient = MockHttpClient();
    localizationRemoteDatasource =
        LocalizationRemoteDatasourceImpl(httpClient: httpClient);
  });

  test('make a request for get the location by ip and return a success',
      () async {
    var ip = '192.168.0.30';
    var url = NamedRoutes.homePage.replaceAll(':ip', ip);
    when(httpClient.get(url)).thenAnswer(
      (realInvocation) async => Response(
        requestOptions: RequestOptions(path: '/json'),
        data: {
          'lat': 19.21,
          'lon': 12.84,
        },
      ),
    );
    var response = await localizationRemoteDatasource.currentPositionByIP(
      ip: ip,
    );

    expect(response, isA<CurrentPositionByIPEntity>());
  });

  test('make a request for get the location by ip and return a error',
      () async {
    var ip = '192.168.0.30';
    var url = NamedRoutes.homePage.replaceAll(':ip', ip);
    when(httpClient.get(url)).thenAnswer((_) async => throw Exception('error'));

    expect(
        () async =>
            await localizationRemoteDatasource.currentPositionByIP(ip: ip),
        throwsA(isA<Exception>()));
  });
}
