import 'package:flutter/material.dart';
import 'package:wordy/module/db.dart';

class VocabPage extends StatelessWidget{
  const VocabPage({Key? key}) : super(key: key);

  Future<List<Vocabulary>> getAllVocab() async{
    var list = await VocabFactory().allVocab();
    return list;
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
              return SizedBox(
                height: 50,
                child: Card(
                  child: Row(
                    children: [
                      Text(vocab.word),
                      Text(vocab.trans),
                    ],
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