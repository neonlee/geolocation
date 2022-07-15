import 'package:connectivity_plus/connectivity_plus.dart';

class Connection {
  final Connectivity _connectivity;

  Connection({required Connectivity connectivity})
      : _connectivity = connectivity;

  Future<bool> hasConnection() async {
    var connection = await _connectivity.checkConnectivity();
    return connection != ConnectivityResult.bluetooth &&
        connection != ConnectivityResult.none;
  }
}
