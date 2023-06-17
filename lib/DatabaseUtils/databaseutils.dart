import 'package:chat_app/model/my-user.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.COLLECTION_NAME)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromjson(snapshot.data()!),
          toFirestore: (value, options) => value.tojson(),
        );
  }
  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.COLLECTION_NAME)
        .withConverter<Room>(
      fromFirestore: (snapshot, options) =>
          Room.fromjson(snapshot.data()!),
      toFirestore: (room, options) => room.tojson(),
    );
  }
  static Future<void> AddRoomFirestore(Room room){
    var Collection=getRoomsCollection();
    var docRef=Collection.doc();
    room.id=docRef.id;
    return docRef.set(room);
  }

  static Future<void> AddUserToFirebaseFirestore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }
 static Future<List<Room>> readRoomsFromFirestore()async{
   QuerySnapshot<Room>snapRooms=await getRoomsCollection().get();
  return snapRooms.docs.map((doc) => doc.data()).toList();
 }
  static Future<MyUser?> ReadUserFromFirestore(String id) async {
    DocumentSnapshot<MyUser> user = await getUsersCollection().doc(id).get();
    var myUser = user.data();
    return myUser;
  }
}
