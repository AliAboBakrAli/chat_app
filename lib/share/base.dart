import 'package:flutter/material.dart';

abstract class BaseNavigator {
  void showLoading();

  void showMessage(String message);

  void hideLoading();
}

abstract class BaseView<T extends StatefulWidget,VM extends BaseViewModel >
    extends State<T>implements BaseNavigator {
 late VM viewModel;

  VM initViewModel();

  @override
  void initState() {
    viewModel= initViewModel();
  }
  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading({message="Loading...."}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Row(
              children: [
                Text(message),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void showMessage(message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    );
  }

}

class BaseViewModel <NAV extends BaseNavigator> extends ChangeNotifier{

NAV? Navigator=null;
}
