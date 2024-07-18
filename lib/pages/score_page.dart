import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/assessment_provider.dart';

class ScorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AssessmentProvider>(context);
    var score = provider
        .calculateScore();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Score'),
      ),
      body: Center(
        child: Text(
          'Your Score: $score',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
