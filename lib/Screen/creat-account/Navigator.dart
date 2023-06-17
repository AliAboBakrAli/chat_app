import 'package:chat_app/model/my-user.dart';
import 'package:chat_app/share/base.dart';

abstract class CreatAccountNavigator extends BaseNavigator{
void goToHome(MyUser myUser);
}