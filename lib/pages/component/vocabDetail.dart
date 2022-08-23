import 'package:flutter/material.dart';
import 'package:wordy/module/vocabDistributor.dart';
import 'package:wordy/module/vocabulary.dart';
import 'package:wordy/pages/modifypage.dart';

typedef Callback = void Function();

class VocabDetailPage extends StatefulWidget {
  final int id;
  final String database;
  final Callback _callback;

  const VocabDetailPage(this._callback, this.id,
      {required this.database, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _VocabDetailPage(id, database: database);
}

class _VocabDetailPage extends State<VocabDetailPage> {
  int initPage = 0;
  PageController controller = PageController(initialPage: 0);
  String database;

  _VocabDetailPage(this.initPage, {required this.database}) {
    controller = PageController(initialPage: initPage);
  }

  Future<List<Vocabulary>> getAllVocab() async {
    return await VocabDistributor.getAllVocab(source: database);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vocabulary>>(
        future: getAllVocab(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Wordy"),
                ),
                body: PageView.builder(
                    controller: controller,
                    itemCount: list!.length,
                    itemBuilder: (context, index) {
                      var vocab = list[index];

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
                            Text(
                              vocab.word,
                              style: const TextStyle(
                                fontSize: 30,
                                fontFamily: "LittlePat",
                              ),
                            ), // word
                            Row(
                              children: [
                                Text(
                                  "(${vocab.pos})",
                                  style: const TextStyle(
                                    fontFamily: "LittlePat",
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 7),
                                  child: Text(
                                    vocab.trans,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ), // translation
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Text(
                              "(definition)\n${vocab.meaning}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "LittlePat",
                              ),
                            ), // definition
                            const SizedBox(height: 20,),
                            if (exampleText != "")
                              Text(
                                exampleText,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: "LittlePat",
                                ),
                              ),
                            const SizedBox(height: 20,),
                            if (database == "user.sql")
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ModifyPage(() {
                                                setState(() {});
                                                widget._callback();
                                              }, vocab: vocab)));
                                },
                                child: const Text("修改內容"),
                              ),
                          ],
                        ),
                      );
                    }));
          } else {
            return const Center(child: Text(""));
          }
        });
  }
}
