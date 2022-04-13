import 'package:cloud_firestore/cloud_firestore.dart';
import 'vote.dart';
class DatabaseService {
  
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference voteCollection = Firestore.instance.collection("voteCollection");

  Future updateUserData(String apples, String oranges) async {
    return await voteCollection.document(uid).setData({
      "apples" : apples,
      "oranges" : oranges, 
    });
  }
  
  List<Vote> voteFromQuerySnapshot (QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Vote(
        apples: doc.data['apples'] ?? "No", 
        oranges: doc.data['oranges'] ?? "No",
      );
    }).toList();
  }
  
  UserVote _userVoteFromDocumentSnapshot(DocumentSnapshot snapshot) {
    return UserVote(
      uid: uid, 
      apples: snapshot.data['apples'], 
      oranges: snapshot.data['oranges'], 
    );
  }

  Stream<List<Vote>> get querySnapshot {
    return voteCollection.snapshots().map(voteFromQuerySnapshot);
  }

  Stream<UserVote> get documentSnapshot {
    return voteCollection.document(uid).snapshots().map(_userVoteFromDocumentSnapshot);
  }
}