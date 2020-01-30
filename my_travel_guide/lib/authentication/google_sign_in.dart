import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_travel_guide/main.dart';
import 'dart:developer' as developer;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseUser user;
GoogleSignInAccount googleSignInAccount;

String email;

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
  assert(user.uid == currentUser.uid);
  developer.log('momom', name: user.email);
  return user.email;
}

void setEmail(String googleEmail) {
  email = googleEmail;
}

String getEmail() {
  return email;
}

void signOutGoogle(BuildContext context) async {
  await googleSignIn.signOut().whenComplete(() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  });
  print("User Sign Out");
}
