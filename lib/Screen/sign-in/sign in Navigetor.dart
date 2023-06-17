import 'package:chat_app/model/my-user.dart';
import 'package:chat_app/share/base.dart';

abstract class LoginNavigator extends BaseNavigator {
    void goToHome(MyUser myUser );
}