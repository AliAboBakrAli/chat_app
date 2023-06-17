import 'package:chat_app/Providers/my_providor.dart';
import 'package:chat_app/Screen/Home/HomeV.dart';
import 'package:chat_app/Screen/sign-in/sign-in-V.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Screen/Rooms/Room-V.dart';
import 'Screen/creat-account/creat_account-V.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: provider.firebaseUser != null
          ? HomeView.Routname
          : LoginScreen.RoutName,
      routes: {
        CreatAccountScreen.Routname: (_) => CreatAccountScreen(),
        LoginScreen.RoutName: (_) => LoginScreen(),
        HomeView.Routname: (_) => HomeView(),
        AddRoomScreen.RoutName:(_)=>AddRoomScreen(),
      },
    );
  }
}
