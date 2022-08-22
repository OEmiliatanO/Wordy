import 'package:flutter/material.dart';
import 'package:wordy/module/vocabDistributor.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vocab = VocabDistributor.randPick();
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          Text(
            vocab.word,
            style: const TextStyle(
              fontSize: 35,
              fontFamily: "NixieOne",
            ),
          ),
          Text(
            vocab.trans,
          ),
        ],
      ),
    );
  }
}