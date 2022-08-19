import 'package:flutter/material.dart';
import 'package:wordy/pages/component/vocabs.dart';

class BuiltinVocab extends StatelessWidget {
  const BuiltinVocab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
          child: Text(
            "Built-in Vocabulary",
            style: TextStyle(color: Colors.grey, fontSize: 25.0),
          ),
        ),
        VocabPage(),
      ],
    );
  }
}