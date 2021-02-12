import 'package:chat/helperfunctions/sharedpref_helper.dart';
import 'package:chat/services/database.dart';
import 'package:chat/views/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthMethods{
  final FirebaseAuth auth = FirebaseAuth.instance;


  getCurrentUser(){
    return auth.currentUser;

  }
  signInWithGoogle(BuildContext context)async
  {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn =  GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount =
       await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication = await
        googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken:  googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
    );
    UserCredential result = await _firebaseAuth.signInWithCredential
      (credential);
    User userDetails = result.user;
    if(result != null ){
      SharedPreferenceHelper().saveUserEmail(userDetails.email);
      SharedPreferenceHelper().saveUserId(userDetails.uid);
      SharedPreferenceHelper().saveDisplayName(userDetails.displayName);
      SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL);

      Map<String, dynamic> userInfoMap = {
        "email": userDetails.email,
        "username" : userDetails.email.replaceAll("@gmail.com",""),
        "name": userDetails.displayName,
        "ingUrl" : userDetails.photoURL
      };

      DatabaseMethods()
          .addUserInfoToDB(userDetails.uid, userInfoMap)
          .then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder:
            (context) => Home()));
          });
    }
  }
}