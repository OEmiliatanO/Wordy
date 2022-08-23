import 'package:flutter/material.dart';
import 'package:wordy/module/vocabDistributor.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vocab = VocabDistributor.randPick();

    String exampleText = "";
    if (vocab.examples[0] != "") {
      exampleText = "(e.g.)\n- ${vocab.examples[0]}";
    }
    for (int i = 1; i <= 4; ++i) {
      if (vocab.examples[i] != "") {
        exampleText += "\n\n- ${vocab.examples[i]}";
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Text(
            "Word Of a Day",
            style: TextStyle(
              fontSize: 30,
              fontFamily: "LittlePat",
              decoration: TextDecoration.underline,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20,),
          Text(
            vocab.word,
            style: const TextStyle(
              fontSize: 23,
              fontFamily: "LittlePat",
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            vocab.trans,
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              "(definition):\n${vocab.meaning}.",
              style: const TextStyle(
                fontSize: 13,
                fontFamily: "LittlePat"
              ),
            ),
          ),
          const SizedBox(height: 20,),
          if (exampleText != "") Text(
            exampleText,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: "LittlePat",
            ),
          ),
        ],
      ),
    );
  }
}