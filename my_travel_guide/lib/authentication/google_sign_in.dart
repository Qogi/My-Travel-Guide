import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_travel_guide/Constant/Constant.dart';
import 'package:my_travel_guide/main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseUser user;
GoogleSignInAccount googleSignInAccount;

String email;
String id;

Future<String> signInWithGoogle() async {
  googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  setEmail(googleSignInAccount.email);
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final AuthResult authResult = await _auth.signInWithCredential(credential);
  user = authResult.user;
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);
  final FirebaseUser currentUser = await _auth.currentUser();
  setUserID(user.uid);
  assert(user.uid == currentUser.uid);
  return user.email;
}

void setUserID(String userID){
  id = userID;
}

String getUserID(){
  return id;
}

void setEmail(String googleEmail) {
  email = googleEmail;
}

String getEmail() {
  return email;
}

void signOutGoogle(BuildContext context) async {
  _auth.signOut();
  await googleSignIn.signOut().whenComplete(() {
    Navigator.popAndPushNamed(context, LOGIN_SCREEN);
  });
  print("User Sign Out");
}
