import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keeps/all_pages/home/home_page.dart';

class LoginController extends GetxController {
  final auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;

  void signInWithGoogle() async {
    _loading = true;
    update();
    final user = await GoogleSignIn().signIn();
    final googleAuth = await user!.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    try {
      await auth.signInWithCredential(credential).then((value) {
        _loading = false;
        update();
        print('Success');
        // ignore: unnecessary_null_comparison
        if (value != null) {
          Get.offAll(() => HomePage());
        }
      }).onError((error, stackTrace) {
        _loading = false;
        update();
        print('error');
      });
    } catch (e) {
      print('error');
    }
  }
}
