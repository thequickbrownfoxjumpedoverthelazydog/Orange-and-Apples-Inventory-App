import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/authenticate.dart';
import 'package:flutter_firebase_practice/home.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SignIn.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return (user != null) ? Home() : Authenticate();
  }
}