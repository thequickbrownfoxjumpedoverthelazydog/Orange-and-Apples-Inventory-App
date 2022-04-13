import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'database.dart';
import 'package:provider/provider.dart';
import 'vote.dart';
import 'allvotes.dart';
class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  int appleVotes = 0;
  int orangeVotes = 0; 
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    
    void _showPopUp() {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: AllVotes(), 
        );
      });
    }

    return  StreamBuilder<UserVote>(
        stream: DatabaseService(uid: user.uid).documentSnapshot,
        builder: (context, snapshot) {
          UserVote vote = snapshot.data;
          if (snapshot.hasData == true) {
             return Center(
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
                FlatButton(
                  child: Text("Show All Votes"), 
                  onPressed: (){
                    _showPopUp();
                  }
                ),
              ],
            ),
          );
          } else {
            return Scaffold(
              body: Text("No Data to Display"),
            );
          }
        }
    );
  }
}