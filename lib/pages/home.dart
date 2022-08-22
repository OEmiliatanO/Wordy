import 'package:flutter/material.dart';
import 'package:wordy/module/vocabDistributor.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vocab = VocabDistributor.randPick();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Flexible(
              child: Text(
                "Word Of a Day",
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "NixieOne",
                  decoration: TextDecoration.underline,
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    vocab.word,
                    style: const TextStyle(
                      fontSize: 30,
                      fontFamily: "NixieOne",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 5.5, 0, 0),
                  child: Text(
                    vocab.trans,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "${vocab.meaning}.",
                  style: const TextStyle(
                    fontSize: 19,
                    fontFamily: "NixieOne"
                  ),
                ),
              )
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                "- ${vocab.examples[0]}",
                style: const TextStyle(
                  fontSize: 19,
                  fontFamily: "NixieOne",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}