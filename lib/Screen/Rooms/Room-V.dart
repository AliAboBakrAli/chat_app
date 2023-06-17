import 'package:chat_app/Screen/Rooms/Room-VM.dart';
import 'package:chat_app/Screen/Rooms/Room_Navigator.dart';
import 'package:chat_app/model/Category.dart';
import 'package:chat_app/share/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static const String RoutName = "AddRoomScreen";

  @override
  State<AddRoomScreen> createState() => _AddRoomScrrenState();
}

class _AddRoomScrrenState extends BaseView<AddRoomScreen, AddRoomViewModel>
    implements RoomNavigator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.Navigator = this;
    selectedcategory = categories[0];
  }

  GlobalKey<FormState> formkay = GlobalKey<FormState>();
  var titleControler = TextEditingController();
  var descControler = TextEditingController();
  var categories = RoomCategory.getCategories();
  late RoomCategory selectedcategory;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Stack(children: [
          Image.asset(
            'assets/images/SIGN UP - PERSONAL.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text('Room'),
            ),
            body: Card(
              margin: EdgeInsets.all(30),
              elevation: 25,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.transparent)),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
                  child: Form(
                      key: formkay,
                      child: Column(children: [
                        Text("Creat New Room",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 15,
                        ),
                        Image.asset("assets/images/addroom.png"),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: titleControler,
                          validator: (text) {
                            if (text!.trim() == "") {
                              return "Please enter Room Title";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: 'Title',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.cyan),
                              )),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        DropdownButton<RoomCategory>(
                          value: selectedcategory,
                          items: categories
                              .map((cat) => DropdownMenuItem<RoomCategory>(
                                  value: cat,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(cat.image),
                                      SizedBox(width: 15),
                                      Text(cat.Name)
                                    ],
                                  )))
                              .toList(),
                          onChanged: (category) {
                            if (category == null) {
                              return;
                            } else {
                              selectedcategory = category;
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        TextFormField(
                          controller: descControler,
                          textInputAction: TextInputAction.done,
                          validator: (text) {
                            if (text!.trim() == "") {
                              return "Please enter Description";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Description',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.cyan),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {CreatRoom();}, child: Text('Creat Room'))
                      ]))),
            ),
          )
        ]));
  }

  void CreatRoom() {
    if (formkay.currentState!.validate()) {
      viewModel.AddRoomtoDB(
          titleControler.text, descControler.text, selectedcategory.id);
    }
  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  @override
  void roomCreated() {
    Navigator.pop(context);
  }
}
