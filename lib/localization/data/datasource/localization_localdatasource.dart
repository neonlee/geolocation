import 'package:cloudwatch/core/constants/named_keys_localstorage.dart';
import 'package:cloudwatch/infra/localstorage.dart';

abstract class LocalizationLocalDatasource {
  String? getLatLang();
  Future<bool> saveLatlang(String value);
}

class LocalizationLocalDatasourceImpl extends LocalizationLocalDatasource {
  final LocalStorage _localStorage;

  LocalizationLocalDatasourceImpl({required LocalStorage localStorage})
      : _localStorage = localStorage;

  @override
  Future<bool> saveLatlang(String value) async {
    return await _localStorage.saveString(NamedKeysLocalStorage.latLang, value);
  }

  @override
  String? getLatLang() {
    return _localStorage.getString(NamedKeysLocalStorage.latLang);
  }
}
