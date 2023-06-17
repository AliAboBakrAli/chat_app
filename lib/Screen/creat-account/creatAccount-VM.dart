import 'package:chat_app/DatabaseUtils/databaseutils.dart';
import 'package:chat_app/model/my-user.dart';
import 'package:chat_app/share/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Navigator.dart';

class CreatAccountViewModel extends BaseViewModel<CreatAccountNavigator> {
  void CreatAccountWithFirebaseAuth(
      String email, String Password, String FirstName, String userName) async {
    try {
      Navigator!.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: Password,
      );
      Navigator!.hideLoading();
      Navigator!.showMessage("Account Created");
      MyUser myUser = MyUser(
          id: credential.user?.uid ?? "",
          fName: FirstName,
          userName: userName,
          email: email);
      DatabaseUtils.AddUserToFirebaseFirestore(myUser).then((value) {
        Navigator!.hideLoading();
        Navigator!.goToHome(myUser);
        return;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator!.hideLoading();
        Navigator!.showMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Navigator!.hideLoading();
        Navigator!.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      Navigator?.hideLoading();
      Navigator?.showMessage(e.toString());
    }
  }
}
