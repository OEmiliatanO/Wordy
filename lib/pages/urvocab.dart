import 'package:flutter/material.dart';
import 'package:wordy/pages/component/vocabs.dart';
import 'package:wordy/pages/addnew.dart';

class UrVocab extends StatelessWidget {
  const UrVocab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // title
        const Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
          child: Text(
            "Your Vocabulary",
            style: TextStyle(color: Colors.grey, fontSize: 25.0),
          ),
        ),
        const VocabPage(database: "user.sql"),
        Stack( // add vocabulary Button
          alignment: Alignment.bottomRight,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("新增單字"),
              onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewPage())); },
            )
          ],
        ),
      ],
    );
  }
}