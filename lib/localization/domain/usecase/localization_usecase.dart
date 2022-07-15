import 'package:cloudwatch/core/exceptions/failure.dart';
import 'package:cloudwatch/localization/domain/entity/current_position_ip_entity.dart';
import 'package:cloudwatch/localization/domain/repository/localization_repository.dart';
import 'package:dartz/dartz.dart';

class LocalizationUsecase {
  final LocalizationRepository _localizationRepository;

  LocalizationUsecase({
    required LocalizationRepository localizationRepository,
  }) : _localizationRepository = localizationRepository;

  Future<Either<Failure, CurrentPositionByIPEntity>> call() async {
    return await _localizationRepository.currentPositionByIP();
  }
}
