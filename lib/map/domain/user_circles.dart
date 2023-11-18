import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

MapObject? mapObject;

CircleMapObject? circleMapObject;

class UserInfo{
  final userNickname;
  final double latitude;
  final double longitude;

  const UserInfo({
    required this.userNickname,
    required this.latitude,
    required this.longitude,
});
}



UserInfo user1 = const UserInfo(userNickname: 'Дэн', latitude: 53.370031, longitude: 83.704332);
UserInfo user2 = const UserInfo(userNickname: 'Женьк', latitude: 53.374776, longitude: 83.710150);

List<UserInfo> userList = [user1, user2];


List<MapObject> createCircles(userList){

  List<MapObject> circles = [];

  for (var i = 0; i < userList.length; i++){
    UserInfo userid = userList[i];
    circles.insert(0, CircleMapObject(
      mapId: MapObjectId(userid.userNickname),
      circle: Circle(center: Point(latitude: userid.latitude, longitude: userid.longitude), radius: 100),
      fillColor: Colors.green,
      strokeWidth: 2,
      strokeColor: Colors.red,
    )
    );
  }

  return circles;
}