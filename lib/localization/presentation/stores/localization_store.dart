import 'package:cloudwatch/localization/domain/entity/current_position_ip_entity.dart';
import 'package:cloudwatch/localization/domain/usecase/localization_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocalizationStore extends ChangeNotifier {
  final LocalizationUsecase _localizationUsecase;

  LocalizationStore({
    required LocalizationUsecase localizationUsecase,
  }) : _localizationUsecase = localizationUsecase;

  String error = '';
  Future<CurrentPositionByIPEntity> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      var response = await _localizationUsecase();
      CurrentPositionByIPEntity? currentPositionByIPEntity;

      response.fold((l) => error = l.message!, (r) {
        currentPositionByIPEntity = r;
      });
      if (error.isNotEmpty) {
        return Future.error(error);
      }
      return currentPositionByIPEntity!;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var response = await Geolocator.getCurrentPosition();
    return CurrentPositionByIPEntity(
      lat: response.latitude,
      lon: response.longitude,
    );
  }
}
