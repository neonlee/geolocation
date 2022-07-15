import 'package:cloudwatch/core/exceptions/failure.dart';
import 'package:cloudwatch/infra/connection.dart';
import 'package:cloudwatch/infra/network_info.dart';
import 'package:cloudwatch/localization/data/datasource/localization_localdatasource.dart';
import 'package:cloudwatch/localization/data/datasource/localization_remotedatasource.dart';
import 'package:cloudwatch/localization/domain/entity/current_position_ip_entity.dart';
import 'package:cloudwatch/localization/domain/repository/localization_repository.dart';
import 'package:dartz/dartz.dart';

class LocalizationRepositoryImpl extends LocalizationRepository {
  final LocalizationRemoteDatasource _localizationRemoteDatasource;
  final GetIP _info;
  final Connection _connection;
  final LocalizationLocalDatasource _localizationLocalDatasource;

  LocalizationRepositoryImpl({
    required LocalizationRemoteDatasource localizationRemoteDatasource,
    required GetIP info,
    required Connection connection,
    required LocalizationLocalDatasource localizationLocalDatasource,
  })  : _localizationRemoteDatasource = localizationRemoteDatasource,
        _info = info,
        _connection = connection,
        _localizationLocalDatasource = localizationLocalDatasource;

  @override
  Future<Either<Failure, CurrentPositionByIPEntity>>
      currentPositionByIP() async {
    if (await _connection.hasConnection()) {
      try {
        var ip = await _info.getIp();
        var response =
            await _localizationRemoteDatasource.currentPositionByIP(ip: ip);
        await _localizationLocalDatasource
            .saveLatlang('${response.lat}/${response.lon}');
        return Right(response);
      } catch (e) {
        return Left(
            Failure(message: 'Ocorreu um erro tente novamente mais tarde'));
      }
    }
    var getLatlang = _localizationLocalDatasource.getLatLang();
    if (getLatlang != null) {
      var latlang = getLatlang.split('/');
      return Right(CurrentPositionByIPEntity(
        lat: double.parse(latlang[0]),
        lon: double.parse(latlang[1]),
      ));
    }
    return Left(Failure(
      message: 'No seu primeiro acesso voce precisa estar conectado',
    ));
  }
}
