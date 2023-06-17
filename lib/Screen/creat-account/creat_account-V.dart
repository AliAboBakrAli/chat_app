import 'package:chat_app/Screen/Home/HomeV.dart';
import 'package:chat_app/model/my-user.dart';
import 'package:chat_app/share/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/my_providor.dart';
import '../sign-in/sign-in-V.dart';
import 'Navigator.dart';
import 'creatAccount-VM.dart';

class CreatAccountScreen extends StatefulWidget {
  static const String Routname = 'CreatAccount';

  @override
  State<CreatAccountScreen> createState() => _CreatAccountScreenState();
}

class _CreatAccountScreenState
    extends BaseView<CreatAccountScreen, CreatAccountViewModel>
    implements CreatAccountNavigator {
  GlobalKey<FormState> formkay = GlobalKey<FormState>();

  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var FNamelcontroller = TextEditingController();
  var usernamedcontroller = TextEditingController();
  CreatAccountViewModel viewModel = CreatAccountViewModel();

  @override
  void initState() {
    viewModel.Navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
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
              title: Text('Creat Account'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formkay,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: FNamelcontroller,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return "Please enter first name";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: 'First Name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.cyan),
                          )),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      controller: usernamedcontroller,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return "Please enter user name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'User Name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.cyan),
                          )),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text!.trim() == "") {
                          return 'Please enter email';
                        }
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return "please enter vaild email";
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.cyan),
                          )),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text!.trim() == "") {
                          return "Please enter password";
                        }
                        return null;
                      },
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.cyan),
                          )),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          creataccount();
                        },
                        child: Text('Creat Account')),
                    TextButton(onPressed: () {
                      Navigator.pushReplacementNamed(
                          context,LoginScreen.RoutName);
                    }, child: Text("I Have An Account ?"))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> creataccount() async {
    if (formkay.currentState!.validate()) {
      viewModel.CreatAccountWithFirebaseAuth(
          emailcontroller.text,
          passwordcontroller.text,
          usernamedcontroller.text,
          FNamelcontroller.text);
    }
  }

  @override
  CreatAccountViewModel initViewModel() {
    return CreatAccountViewModel();
  }

  @override
  void goToHome(MyUser myUser) {
    var provider = Provider.of<MyProvider>(context,listen: false);

    Navigator.pushReplacementNamed(context, HomeView.Routname);
  }
}
