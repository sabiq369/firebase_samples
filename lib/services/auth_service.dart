import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mastering_firebase/utils/widgets/common_functions.dart';

class AuthService {
  signInWithGoogle() async {
    // try {
    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create new credential for user
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    //finally let's sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
    // } catch (e) {
    //   showToast(msg: e.toString());
    // }
  }
}
