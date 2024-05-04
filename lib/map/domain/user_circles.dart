import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

MapObject? mapObject;

CircleMapObject? circleMapObject;

class UserInfo{
  final userNickname;
  final double latitude;
  final double longitude;
  final String picName;
  final String trackName;

  const UserInfo({
    required this.userNickname,
    required this.latitude,
    required this.longitude,
    required this.picName,
    required this.trackName,
});
}



UserInfo user1 = const UserInfo(userNickname: 'Дэн', latitude: 53.370031, longitude: 83.704332, picName: 'assets/images/algorithm.png', trackName: 'algorithm');
UserInfo user2 = const UserInfo(userNickname: 'Женьк', latitude: 53.374776, longitude: 83.710150, picName: 'assets/images/TRAUMATIC.jpg', trackName: 'traumatic');

List<UserInfo> userList = [user1, user2];

List<MapObject> createCircles(userList){
  List<MapObject> circles = [];

  for (var i = 0; i < userList.length; i++){
    UserInfo userid = userList[i];
    circles.insert(0, CircleMapObject(
      mapId: MapObjectId(userid.userNickname),
      circle: Circle(center: Point(latitude: userid.latitude, longitude: userid.longitude), radius: 100),
      fillColor: Colors.black12.withOpacity(0.5),
      strokeWidth: 2,
      strokeColor: Colors.black,
    )
    );
  }

  return circles;
}
