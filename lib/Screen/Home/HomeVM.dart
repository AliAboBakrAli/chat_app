import 'package:chat_app/DatabaseUtils/databaseutils.dart';
import 'package:chat_app/share/base.dart';

import '../../model/room.dart';

class HomeViewModel extends BaseViewModel {
  List<Room> Rooms = [];

  void readRooms() {
    DatabaseUtils.readRoomsFromFirestore().then((value) {
      Rooms = value;
    }).catchError((error) {
      Navigator!.showMessage(error.toString());
    });
  }
}
