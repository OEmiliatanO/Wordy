import 'package:flutter/material.dart';
import 'package:wordy/module/vocabDistributor.dart';
import 'package:wordy/module/vocabulary.dart';
import 'package:wordy/pages/component/vocabDetail.dart';
import 'package:wordy/pages/addnew.dart';

class VocabPage extends StatefulWidget {
  final String database;
  const VocabPage({Key? key, required this.database}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VocabPageState(database: database);
}

class _VocabPageState extends State<VocabPage> {
  String database;
  _VocabPageState({required this.database});

  Future<List<Vocabulary>> getAllVocab() async{
    return await VocabDistributor.getAllVocab(source: database);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Flexible(
            child: FutureBuilder<List<Vocabulary>>(
              future: getAllVocab(),
              builder: (context, snapshot){
                if (snapshot.hasData){
                  var list = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: list!.length,
                    itemBuilder: (context, index){
                      var vocab = list[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => VocabDetailPage((){ setState(() { }); }, index, database: database,)));
                        },
                        child: SizedBox(
                          height: 50,
                          child: Card(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    vocab.word,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: "NixieOne",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    vocab.trans,
                                    style: const TextStyle(
                                      fontSize: 16
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  );
                }
                else{
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "no vocabulary currently",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    )
                  );
                }
              }
            ),
          ),
          if (database == "user.sql") ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("新增單字"),
            onPressed: () {
              // TODO: improve the performance
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewPage( () { setState(() {}); }) ));
            },
          ),
        ],
      ),
    );
  }

}