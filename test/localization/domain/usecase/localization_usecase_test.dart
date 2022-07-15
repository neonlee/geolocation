import 'package:cloudwatch/core/exceptions/failure.dart';
import 'package:cloudwatch/localization/domain/entity/current_position_ip_entity.dart';
import 'package:cloudwatch/localization/domain/repository/localization_repository.dart';
import 'package:cloudwatch/localization/domain/usecase/localization_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'localization_usecase_test.mocks.dart';

@GenerateMocks([LocalizationRepository])
void main() {
  late LocalizationUsecase localizationUsecase;
  late LocalizationRepository localizationRepository;
  setUp(() {
    localizationRepository = MockLocalizationRepository();
    localizationUsecase = LocalizationUsecase(
      localizationRepository: localizationRepository,
    );
  });
  test(('usecase return success'), () async {
    var curerntPosition = CurrentPositionByIPEntity(lat: 12.11, lon: 125.5);

    when(localizationRepository.currentPositionByIP())
        .thenAnswer((realInvocation) async => Right(curerntPosition));
    var response = await localizationUsecase();
    var result = response.fold((l) => l, (r) => r);
    expect(result, isA<CurrentPositionByIPEntity>());
  });

  test(('usecase return failure'), () async {
    when(localizationRepository.currentPositionByIP())
        .thenAnswer((realInvocation) async => Left(Failure()));
    var response = await localizationUsecase();
    var result = response.fold((l) => l, (r) => r);
    expect(result, isA<Failure>());
  });
}
