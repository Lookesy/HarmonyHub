import 'dart:async';

import 'package:flutter/material.dart';

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

  CircleMapObject? circleMapObject;

  MapObject? mapObject;


  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }


  List<MapObject> _circlesList(){
    const List<MapObject> circles = [
      CircleMapObject(
        mapId: MapObjectId('circle_1'),
        circle: Circle(center: Point(latitude: 53.375191, longitude: 83.714504), radius: 100),
        fillColor: Color.fromRGBO(219, 00, 88, 98),
        strokeWidth: 2,
        strokeColor: Color.fromRGBO(156, 22, 18, 80),
      ),
      CircleMapObject(
        mapId: MapObjectId('circle_2'),
        circle: Circle(center: Point(latitude: 53.370158, longitude: 83.713960), radius: 100),
        fillColor: Color.fromRGBO(35, 84, 121, 98),
        strokeWidth: 2,
        strokeColor: Color.fromRGBO(156, 22, 18, 80),
      ),
    ];
    return circles;
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
        mapObjects: _circlesList(),
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




