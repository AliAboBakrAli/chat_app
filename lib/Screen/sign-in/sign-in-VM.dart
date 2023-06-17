import 'package:chat_app/DatabaseUtils/databaseutils.dart';
import 'package:chat_app/Screen/sign-in/sign%20in%20Navigetor.dart';
import 'package:chat_app/model/my-user.dart';
import 'package:chat_app/share/base.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  void LoginAccountWithFirebaseAuth(String email, String Password) async {
    try {
      Navigator!.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: Password,
      );
      Navigator!.hideLoading();
      Navigator!.showMessage("successfully logged");
      MyUser? myUser =
          await DatabaseUtils.ReadUserFromFirestore(credential.user?.uid ?? "");
      if(myUser!=null){
        Navigator!.hideLoading();
    Navigator!.goToHome(myUser);
    return;
      }
    } on FirebaseAuthException catch (e) {
      Navigator!.hideLoading();
      Navigator!.showMessage('wrong email or password');
    } catch (e) {
      Navigator?.hideLoading();
      Navigator?.showMessage(e.toString());
    }
  }
}
