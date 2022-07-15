import 'dart:async';

import 'package:cloudwatch/localization/domain/entity/current_position_ip_entity.dart';
import 'package:cloudwatch/localization/presentation/stores/localization_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  final LocalizationStore _localizationStore = GetIt.I.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<CurrentPositionByIPEntity>(
          future: _localizationStore.determinePosition(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var position = snapshot.data;
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(position!.lat, position.lon),
                  zoom: 14.4746,
                ),
                markers: {
                  Marker(
                    position: LatLng(position.lat, position.lon),
                    markerId: const MarkerId('null'),
                  )
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
