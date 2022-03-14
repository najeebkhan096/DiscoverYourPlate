import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';





class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user

  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(user.uid) : null;
  }




  // auth change user stream
  Stream<MyUser?> get user {

    return _auth.authStateChanges()
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }


  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      FirebaseAuthException abc=error as FirebaseAuthException;
      print("love "+abc.message.toString());
      throw abc.message.toString();
    }
  }


  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // return _userFromFirebaseUser(user);
      return user;
    } catch (error) {
      FirebaseAuthException abc=error as FirebaseAuthException;

      throw abc.message.toString();

    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}

