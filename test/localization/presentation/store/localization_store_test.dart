import 'package:cloudwatch/localization/domain/entity/current_position_ip_entity.dart';
import 'package:cloudwatch/localization/domain/usecase/localization_usecase.dart';
import 'package:cloudwatch/localization/presentation/stores/localization_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'localization_store_test.mocks.dart';

@GenerateMocks([LocalizationUsecase, Geolocator])
void main() {
  late LocalizationStore localizationStore;
  late LocalizationUsecase localizationUsecase;
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    localizationUsecase = MockLocalizationUsecase();

    localizationStore = LocalizationStore(
      localizationUsecase: localizationUsecase,
    );
  });

  test('get current position and return a success', () async {
    when(Geolocator.isLocationServiceEnabled()).thenAnswer((_) async => true);
    var result = await localizationStore.determinePosition();

    expect(result, isA<CurrentPositionByIPEntity>());
  });
}
