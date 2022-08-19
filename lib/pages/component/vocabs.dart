import 'package:flutter/material.dart';
import 'package:wordy/module/db.dart';
import 'package:wordy/pages/component/vocabDetail.dart';

class VocabPage extends StatelessWidget{
  const VocabPage({Key? key}) : super(key: key);

  Future<List<Vocabulary>> getAllVocab() async{
    return await VocabDistributor().getAllVocab();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vocabulary>>(
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
                  Navigator.push(context, MaterialPageRoute(builder: (_) => VocabDetailPage(index)));
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
                              fontSize: 16
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
          return const Center(child: Text("no data"));
        }
      }
    );
  }

}