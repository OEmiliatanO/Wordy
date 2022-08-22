import 'package:flutter/material.dart';
import 'package:wordy/pages/component/vocabs.dart';


class UrVocab extends StatelessWidget {
  const UrVocab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // title
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
          child: Text(
            "Your Vocabulary",
            style: TextStyle(color: Colors.grey, fontSize: 25.0),
          ),
        ),
        VocabPage(database: "user.sql"),
      ],
    );
  }
}