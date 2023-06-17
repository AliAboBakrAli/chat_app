import 'package:chat_app/model/my-user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../DatabaseUtils/databaseutils.dart';

class MyProvider extends ChangeNotifier {
  MyUser? myUser;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initMyuser();
    }
  }

  void initMyuser() async {
    myUser = await DatabaseUtils.ReadUserFromFirestore(firebaseUser?.uid ?? "");
  }
}
