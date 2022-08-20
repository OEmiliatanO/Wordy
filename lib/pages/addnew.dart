import 'package:flutter/material.dart';
import 'package:wordy/module/vocabDistributor.dart';
import 'package:wordy/module/vocabulary.dart';

class VocabForm extends StatefulWidget{
  const VocabForm({Key? key}) : super(key: key);

  @override
  State<VocabForm> createState() => _FormState();
}

enum ContrId { word,pos,trans,meaning,example1,example2,example3,example4,example5 }
class _FormState extends State<VocabForm>{
  final _controllers = List.generate(9, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: _controllers[ContrId.word.index],
              decoration: const InputDecoration(
                labelText: "單字",
              ),
            ), // word
            TextField(
              controller: _controllers[ContrId.pos.index],
              decoration: const InputDecoration(
                labelText: "詞性",
              ),
            ), // pos
            TextField(
              controller: _controllers[ContrId.trans.index],
              decoration: const InputDecoration(
                labelText: "中文",
              ),
            ), // trans
            TextField(
              controller: _controllers[ContrId.meaning.index],
              decoration: const InputDecoration(
                labelText: "定義",
              ),
            ), // meaning
            TextField(
              controller: _controllers[ContrId.example1.index],
              decoration: const InputDecoration(
                labelText: "例句",
              ),
            ), // example1
            TextField(
              controller: _controllers[ContrId.example2.index],
              decoration: const InputDecoration(
                labelText: "例句",
              ),
            ), // example2
            TextField(
              controller: _controllers[ContrId.example3.index],
              decoration: const InputDecoration(
                labelText: "例句",
              ),
            ), // example3
            TextField(
              controller: _controllers[ContrId.example4.index],
              decoration: const InputDecoration(
                labelText: "例句",
              ),
            ), // example4
            TextField(
              controller: _controllers[ContrId.example5.index],
              decoration: const InputDecoration(
                labelText: "例句",
              ),
            ), // example5
            Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.all(13),
                  child: Text("+新增"),
                ),
                onPressed: () {
                  VocabDistributor.update(
                    source: "user.sql",
                    vocab: Vocabulary(
                      "\"${_controllers[ContrId.word.index].text}\"",
                      "\"${_controllers[ContrId.pos.index].text}\"",
                      "\"${_controllers[ContrId.trans.index].text}\"",
                      "\"${_controllers[ContrId.meaning.index].text}\"",
                      [
                        "\"${_controllers[ContrId.example1.index].text}\"",
                        "\"${_controllers[ContrId.example2.index].text}\"",
                        "\"${_controllers[ContrId.example3.index].text}\"",
                        "\"${_controllers[ContrId.example4.index].text}\"",
                        "\"${_controllers[ContrId.example5.index].text}\"",
                      ]
                    )
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddNewPage extends StatelessWidget{
  const AddNewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "新增單字",
        ),
      ),
      body: const VocabForm(),
    );
  }

}