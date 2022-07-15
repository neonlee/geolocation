import 'package:cloudwatch/infra/connection.dart';
import 'package:cloudwatch/infra/http_client.dart';
import 'package:cloudwatch/infra/localstorage.dart';
import 'package:cloudwatch/infra/network_info.dart';
import 'package:cloudwatch/localization/data/datasource/localization_localdatasource.dart';
import 'package:cloudwatch/localization/data/datasource/localization_remotedatasource.dart';
import 'package:cloudwatch/localization/data/repository/localization_repository_impl.dart';
import 'package:cloudwatch/localization/domain/repository/localization_repository.dart';
import 'package:cloudwatch/localization/domain/usecase/localization_usecase.dart';
import 'package:cloudwatch/localization/presentation/stores/localization_store.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var _getIt = GetIt.I;

void initInjection() async {
  _getIt.registerFactory(() => Dio(
        BaseOptions(
          baseUrl: 'http://ip-api.com/',
          connectTimeout: 10000,
          sendTimeout: 10000,
        ),
      ));

  _getIt.registerFactory(() => Connectivity());
  _getIt.registerFactory(() => GetIP());

  _getIt.registerFactoryAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  }, instanceName: 'sharedPrefs');

  _getIt.registerFactory(() {
    var sharedPrefs =
        _getIt.getAsync<SharedPreferences>(instanceName: 'sharedPrefs');
    return LocalStorage(sharedPreferences: sharedPrefs);
  });

  _getIt.registerFactory(() => Connection(connectivity: _getIt.get()));

  _getIt.registerFactory(() => HttpClient(dio: _getIt.get()));

  _getIt.registerFactory<LocalizationLocalDatasource>(
      () => LocalizationLocalDatasourceImpl(localStorage: _getIt.get()));

  _getIt.registerFactory<LocalizationRemoteDatasource>(
      () => LocalizationRemoteDatasourceImpl(httpClient: _getIt.get()));

  _getIt.registerFactory<LocalizationRepository>(
    () => LocalizationRepositoryImpl(
      localizationLocalDatasource: _getIt.get(),
      info: _getIt.get(),
      connection: _getIt.get(),
      localizationRemoteDatasource: _getIt.get(),
    ),
  );

  _getIt.registerFactory(
    () => LocalizationUsecase(localizationRepository: _getIt.get()),
  );

  _getIt.registerFactory(
    () => LocalizationStore(localizationUsecase: _getIt.get()),
  );
}
