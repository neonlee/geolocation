import 'package:cloudwatch/core/exceptions/failure.dart';
import 'package:cloudwatch/infra/connection.dart';
import 'package:cloudwatch/infra/network_info.dart';
import 'package:cloudwatch/localization/data/datasource/localization_localdatasource.dart';
import 'package:cloudwatch/localization/data/datasource/localization_remotedatasource.dart';
import 'package:cloudwatch/localization/data/repository/localization_repository_impl.dart';
import 'package:cloudwatch/localization/domain/entity/current_position_ip_entity.dart';
import 'package:cloudwatch/localization/domain/repository/localization_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'localization_repository_test.mocks.dart';

@GenerateMocks([
  LocalizationRemoteDatasource,
  GetIP,
  LocalizationLocalDatasource,
  Connection,
])
void main() {
  late LocalizationRepository localizationRepository;
  late LocalizationRemoteDatasource localizationRemoteDatasource;
  late LocalizationLocalDatasource localizationLocalDatasource;
  late GetIP getIP;
  late Connection connection;
  setUp(() {
    localizationRemoteDatasource = MockLocalizationRemoteDatasource();
    localizationLocalDatasource = MockLocalizationLocalDatasource();
    getIP = MockGetIP();
    connection = MockConnection();
    localizationRepository = LocalizationRepositoryImpl(
      localizationRemoteDatasource: localizationRemoteDatasource,
      info: getIP,
      connection: connection,
      localizationLocalDatasource: localizationLocalDatasource,
    );
  });

  test('create a request and return a success', () async {
    CurrentPositionByIPEntity currentIp = CurrentPositionByIPEntity(
      lat: 12.21,
      lon: 12.21,
    );
    var ip = '192.168.0.30';

    when(localizationLocalDatasource
            .saveLatlang('${currentIp.lat}/${currentIp.lon}'))
        .thenAnswer((_) async => true);

    when(connection.hasConnection()).thenAnswer((_) async => true);

    when(getIP.getIp()).thenAnswer((_) async => ip);

    when(localizationRemoteDatasource.currentPositionByIP(ip: ip))
        .thenAnswer((realInvocation) async => currentIp);

    var response = await localizationRepository.currentPositionByIP();

    expect(response, isA<CurrentPositionByIPEntity>());
  });

  test('create a request and return a error when try to get a ip', () async {
    CurrentPositionByIPEntity currentIp = CurrentPositionByIPEntity(
      lat: 12.21,
      lon: 12.21,
    );
    var ip = '192.168.0.30';

    when(localizationLocalDatasource
            .saveLatlang('${currentIp.lat}/${currentIp.lon}'))
        .thenAnswer((_) async => true);

    when(connection.hasConnection()).thenAnswer((_) async => true);

    when(getIP.getIp()).thenThrow(Exception());

    when(localizationRemoteDatasource.currentPositionByIP(ip: ip))
        .thenAnswer((realInvocation) async => currentIp);

    var response = await localizationRepository.currentPositionByIP();
    final result = response.fold((l) => l, (r) => r);
    expect(result, isA<Failure>());
  });

  test('return a success when not have connection', () async {
    when(localizationLocalDatasource.getLatLang())
        .thenAnswer((_) => '12.21/12.55');

    when(connection.hasConnection()).thenAnswer((_) async => false);

    var response = await localizationRepository.currentPositionByIP();

    expect(response, isA<CurrentPositionByIPEntity>());
  });

  test('return a error when not have connection and not save', () async {
    when(localizationLocalDatasource.getLatLang()).thenAnswer((_) => null);

    when(connection.hasConnection()).thenAnswer((_) async => false);
    var response = await localizationRepository.currentPositionByIP();
    final result = response.fold((l) => l, (r) => r);
    expect(result, isA<Failure>());
  });
}
