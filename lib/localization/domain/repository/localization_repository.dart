import 'package:cloudwatch/core/exceptions/failure.dart';
import 'package:cloudwatch/localization/domain/entity/current_position_ip_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LocalizationRepository {
  Future<Either<Failure, CurrentPositionByIPEntity>> currentPositionByIP();
}
