import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  Room room;
  RoomWidget(this.room);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Image.asset("assets/images/${room.CatId}.jpg"),
          Text(room.title),
        ],
      ),
    );
  }
}
