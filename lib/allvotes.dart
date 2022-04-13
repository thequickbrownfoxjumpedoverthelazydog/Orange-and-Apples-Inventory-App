import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'vote.dart';
class AllVotes extends StatefulWidget {

  @override
  _AllVotesState createState() => _AllVotesState();
}

class _AllVotesState extends State<AllVotes> {
  @override
  Widget build(BuildContext context) {
    final votes = Provider.of<List<Vote>>(context);
    return ListView.builder(
      itemCount: votes.length, 
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Text(votes[index].apples),
              Text(votes[index].apples),
            ],
          ), 
        );
      }
    );
  }
}