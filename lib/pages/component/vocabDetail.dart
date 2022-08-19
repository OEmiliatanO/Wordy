import 'package:flutter/material.dart';
import 'package:wordy/module/db.dart';

class VocabDetailPage extends StatefulWidget{
  final int id;
  final String database;
  const VocabDetailPage(this.id, {required this.database, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VocabDetailPage(id, database: database);
}

class _VocabDetailPage extends State<VocabDetailPage>{
  int initPage = 0;
  PageController controller = PageController(initialPage: 2);
  String database;

  _VocabDetailPage(int id, {required this.database}){
    initPage = id;
    controller = PageController(initialPage: initPage);
  }

  Future<List<Vocabulary>> getAllVocab() async{
    return await VocabDistributor(database: database).getAllVocab();
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
                                      fontSize: 30
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 5.5, 0, 0),
                                  child: Text("(${vocab.pos})"),
                                ),
                              ]
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  vocab.trans,
                                  style: const TextStyle(
                                    fontSize: 15
                                  ),
                                )
                              ),
                            ]
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                          child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "definition:\n${vocab.meaning}.",
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "- ${vocab.examples[0]}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ]
                          ),
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