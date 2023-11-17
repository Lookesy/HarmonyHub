import 'dart:async';

import 'package:flutter/material.dart';
import 'app_lat_long.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'location_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> with AutomaticKeepAliveClientMixin<MapScreen>{
  @override
  bool get wantKeepAlive => true;
  final mapControllerCompleter = Completer<YandexMapController>();

  late final YandexMapController yandexMapController;

  late PlacemarkMapObject placemarkMapObject;

  CameraPosition? _userLocation;

  UserLocationView? userLocationView;

  late UserLocationCallback userLocationCallback;



  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),
        ),
        onPressed: () async {
          if (_userLocation != null) {
            await yandexMapController.moveCamera(
              CameraUpdate.newCameraPosition(
                _userLocation!.copyWith(zoom: 15),
              ),
              animation: const MapAnimation(
                type: MapAnimationType.linear,
                duration: 0.3,
              ),
            );
          }
        },
        child: const Icon(Icons.info)
      ),
      body: YandexMap(
        mapObjects: [],
        nightModeEnabled: true,
        onMapCreated: (controller) async {
          yandexMapController = controller;
          mapControllerCompleter.complete(controller);
          yandexMapController.toggleUserLayer(visible: true);
          await _initPermission();
        },
        onUserLocationAdded: (view) async {
          // получаем местоположение пользователя
          _userLocation = await yandexMapController.getUserCameraPosition();
          // если местоположение найдено, центрируем карту относительно этой точки
          if (_userLocation != null) {
            await yandexMapController.moveCamera(
              CameraUpdate.newCameraPosition(
                _userLocation!.copyWith(zoom: 15),
              ),
              animation: const MapAnimation(
                type: MapAnimationType.linear,
                duration: 0.3,
              ),
            );
          }
          // меняем внешний вид маркера - делаем его непрозрачным
          return view.copyWith(
            arrow: view.arrow.copyWith(opacity: 1, isVisible: false, icon: PlacemarkIcon.single(PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('assets/images/location.png'), scale: 0.1, anchor: const Offset(0, 1)))),
            accuracyCircle: view.accuracyCircle.copyWith(isVisible: false, strokeWidth: 0, fillColor: const Color.fromRGBO(10, 12, 131, 00)),
            pin: view.pin.copyWith(
              opacity: 1,
              icon: PlacemarkIcon.single(PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('assets/images/location.png'), anchor: const Offset(0, 1), scale: 0.1)),

            ),
          );
        },
      ));
    }


  /// Проверка разрешений на доступ к геопозиции пользователя
  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
  }


}


