import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_score_app/entities/football.dart';

import '../../widgets/football_scorecard.dart';

class MatchlistScreen extends StatefulWidget {
  const MatchlistScreen({super.key});

  @override
  State<MatchlistScreen> createState() => _MatchlistScreenState();
}

class _MatchlistScreenState extends State<MatchlistScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Football> matchList = [];
  Future<void> getFootballMatches() async {
    matchList.clear();
    QuerySnapshot result = await firebaseFirestore.collection('FootBall').get();
    for (QueryDocumentSnapshot doc in result.docs) {
      matchList.add(Football(
          matchName: doc.id,
          team1Name: doc.get('team1Name'),
          team2Name: doc.get('team2Name'),
          team1Score: doc.get('team1Score'),
          team2Score: doc.get('team2Score')));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFootballMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Football'),
      ),
      body: StreamBuilder(
          stream: firebaseFirestore.collection('FootBall').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData == false) {
              return Center(
                child: Text('The list is empty'),
              );
            }
            matchList.clear();
            for (QueryDocumentSnapshot doc in snapshot.data?.docs ?? []) {
              matchList.add(Football(
                  matchName: doc.id,
                  team1Name: doc.get('team1Name'),
                  team2Name: doc.get('team2Name'),
                  team1Score: doc.get('team1Score'),
                  team2Score: doc.get('team2Score')));
            }
            return ListView.builder(
                itemCount: matchList.length,
                itemBuilder: (context, index) {
                  return Football_score_card(
                    footballScore: matchList[index],
                  );
                });
          }),
    );
  }
}
