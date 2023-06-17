import 'package:chat_app/Screen/Rooms/Room_Navigator.dart';
import 'package:chat_app/share/base.dart';

import '../../DatabaseUtils/databaseutils.dart';
import '../../model/room.dart';

class AddRoomViewModel extends BaseViewModel<RoomNavigator>{
  void AddRoomtoDB(String title,String desc,String CatId){
    Room room=Room( title: title, desc:desc, CatId:CatId);
    DatabaseUtils.AddRoomFirestore(room).then((value){
Navigator!.roomCreated();
    }).catchError((error){

    });
  }

}