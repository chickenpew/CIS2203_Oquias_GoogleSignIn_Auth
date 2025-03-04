import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount user;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =  await googleUser?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Logout

  Future logout() async {
    try {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();

      return true;
    }catch(e){
      return null;
    }
  }

  // Create User
  Future<UserCredential> createUser(String email, String password) async =>
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> signInWithEmailandPassword(String email, String password) async => 
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
}