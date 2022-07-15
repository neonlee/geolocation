import 'package:cloudwatch/localization/domain/entity/current_position_ip_entity.dart';

class CurrentPositionByIPModel extends CurrentPositionByIPEntity {
  CurrentPositionByIPModel({
    required super.lat,
    required super.lon,
  });
  factory CurrentPositionByIPModel.fromJson(dynamic json) {
    return CurrentPositionByIPModel(
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}
