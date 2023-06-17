import 'package:chat_app/Screen/creat-account/creat_account-V.dart';
import 'package:chat_app/Screen/sign-in/sign%20in%20Navigetor.dart';
import 'package:chat_app/Screen/sign-in/sign-in-VM.dart';
import 'package:chat_app/model/my-user.dart';
import 'package:chat_app/share/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/my_providor.dart';
import '../Home/HomeV.dart';

class LoginScreen extends StatefulWidget {
  static const String RoutName = "Login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  GlobalKey<FormState> formkay = GlobalKey<FormState>();
  LoginViewModel viewModel = LoginViewModel();
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
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
              title: Text('Sign IN'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formkay,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return "Please enter Email";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
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
                      controller: passwordcontroller,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return "Please enter Password";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.cyan),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          creataccount();
                        },
                        child: Text('Login')),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, CreatAccountScreen.Routname);
                        },
                        child: Text("Don't Have An Account ?"))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void creataccount() {
    viewModel.LoginAccountWithFirebaseAuth(
        emailcontroller.text, passwordcontroller.text);
  }

  @override
  LoginViewModel initViewModel() {
    return initViewModel();
  }

  @override
  void goToHome(MyUser myUser) {
    var provider = Provider.of<MyProvider>(context,listen: false);
    Navigator.pushReplacementNamed(context, HomeView.Routname);
  }
}
