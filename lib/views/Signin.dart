import 'package:flutter/material.dart';

class SignIn extends StatefulWidget{
  @override
  _SignInState createState() =>_SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(
        title: Text("chat"),
      ),
      body: Center(
        child:  Container(
          child:  Text("Sign In with Google")
        ),
      ),
    );
  }


}

