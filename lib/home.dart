import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';
import 'body.dart';
import 'vote.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> { 

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return StreamBuilder<UserVote>(
      stream: DatabaseService(uid: user.uid).documentSnapshot,
      builder: (context, snapshot) {
        UserVote vote = snapshot.data; 
        if (snapshot.hasData == true) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Home"), 
              actions: [
                FlatButton(
                  onPressed: ()async {
                    _auth.authSignOut();
                  }, 
                  child: Text("Sign Out"),
                ),
              ],
              backgroundColor: (vote.apples == "Apples" && vote.oranges == "No") ? Colors.red : Colors.orange,  
            ), 
            body: Center(
              child: Column(
                children: [
                  FlatButton(
                      child: Text("Oranges"), 
                      onPressed: ()async {
                        DatabaseService(uid: user.uid).updateUserData("No", "Oranges");
                      }, 
                      color: Colors.orange, 
                    ),
                    FlatButton(
                      child: Text("Apples"), 
                      onPressed: ()async {
                        DatabaseService(uid: user.uid).updateUserData("Apples", "No");
                      }, 
                      color: Colors.red, 
                    ),
                    (vote.apples == "Apples") ? Text("Vote: Apples") : Text(""),
                    (vote.oranges == "Oranges") ? Text("Vote: Oranges") : Text(""),
                ],
              ),
            ), 
        );
        } else {
          return Scaffold(
            body: Text("Unable to Find Data")
          );
        }
        
      }
    );
  }
}