import 'package:flutter/material.dart';
import 'package:wordy/pages/component/vocabs.dart';

class UrVocab extends StatelessWidget {
  const UrVocab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
          child: Text(
            "Your Vocabulary",
            style: TextStyle(color: Colors.grey, fontSize: 13.0),
          ),
        ),
        VocabPage(),
      ],
    );
  }
}