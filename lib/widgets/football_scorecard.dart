import 'package:flutter/material.dart';
import 'package:live_score_app/entities/football.dart';

class Football_score_card extends StatelessWidget {
  const Football_score_card({
    super.key,
    required this.footballScore,
  });
  final Football footballScore;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      footballScore.team1Score.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      footballScore.team1Name.toString(),
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                Text('VS', style: TextStyle(fontSize: 18)),
                Column(
                  children: [
                    Text(
                      footballScore.team2Score.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      footballScore.team2Name.toString(),
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
