import 'package:dart_ipify/dart_ipify.dart';

class GetIP {
  Future<String> getIp() async {
    try {
      return await Ipify.ipv4();
    } catch (e) {
      rethrow;
    }
  }
}
