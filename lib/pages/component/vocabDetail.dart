import 'package:flutter/material.dart';
import 'package:wordy/module/vocabDistributor.dart';
import 'package:wordy/module/vocabulary.dart';
import 'package:wordy/pages/modifypage.dart';

typedef Callback = void Function();

class VocabDetailPage extends StatefulWidget{
  final int id;
  final String database;
  final Callback _callback;

  const VocabDetailPage(this._callback, this.id, {required this.database, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VocabDetailPage(id, database: database);
}

class _VocabDetailPage extends State<VocabDetailPage>{
  int initPage = 0;
  PageController controller = PageController(initialPage: 0);
  String database;

  _VocabDetailPage(this.initPage, {required this.database}){
    controller = PageController(initialPage: initPage);
  }

  Future<List<Vocabulary>> getAllVocab() async{
    return await VocabDistributor.getAllVocab(source: database);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vocabulary>>(
        future: getAllVocab(),
        builder: (context, snapshot){
          if (snapshot.hasData){
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
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 40, 0),
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
                                    padding: const EdgeInsets.fromLTRB(20, 5.5, 0, 0),
                                  child: Text("(${vocab.pos})"),
                                ),
                              ]
                          ),
                        ), // word
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  vocab.trans,
                                  style: const TextStyle(
                                    fontSize: 20
                                  ),
                                )
                              ),
                            ]
                          ),
                        ), // translation
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                          child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "definition:\n${vocab.meaning}.",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: "NixieOne",
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ), // definition
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "- ${vocab.examples[0]}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "NixieOne",
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ), // example0
                        // TODO: add more examples
                        if (database == "user.sql") ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ModifyPage((){ setState(() {}); widget._callback(); },vocab: vocab)));
                          },
                          child: const Text("修改內容"),
                        ),
                      ],
                    ),
                  ),
                );
              })
            );
          }
          else{
            return const Center(child: Text(""));
          }
        }
    );
  }

}