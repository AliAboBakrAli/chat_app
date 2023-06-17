import 'dart:ffi';

import 'package:chat_app/Screen/Home/HomeNav.dart';
import 'package:chat_app/Screen/Home/HomeVM.dart';
import 'package:chat_app/Screen/Home/RoomWidget.dart';
import 'package:chat_app/Screen/Rooms/Room-V.dart';
import 'package:chat_app/Screen/sign-in/sign-in-V.dart';
import 'package:chat_app/share/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  static const String Routname = "HomeView";

  @override
  State<HomeView> createState() => _HomeViewState();
}

HomeView viewModel = HomeView();

class _HomeViewState extends BaseView<HomeView, HomeViewModel>
    implements HomeNavigator {
  @override
  void initState() {
    super.initState();
    HomeViewModel().readRooms();
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/SIGN UP - PERSONAL.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoomScreen.RoutName);
              },
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text("Chat-App"),
              actions: [
                IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.RoutName);
                    },
                    icon: Icon(Icons.logout))
              ],
            ),
            body: Consumer<HomeViewModel>(
              builder: (_, Homeviewmodel, c) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return RoomWidget(Homeviewmodel.Rooms[index]);
                  },
                  itemCount: HomeViewModel().Rooms.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
}
