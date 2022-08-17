import 'package:flutter/material.dart';
import 'package:wordy/pages/home.dart';
import 'package:wordy/pages/urvocab.dart';
import 'package:wordy/pages/builtinvocab.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  NavState createState() => NavState();
}

class NavState extends State<Nav>{
  int pageIdx = 0;
  void tap(int id){
    setState(() {
      Navigator.pop(context);
      pageIdx = id;
    });
  }
  static List<Widget> pages = <Widget>[
    const Home(),
    const UrVocab(),
    const BuiltinVocab()
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wordy"),
      ),
      body: IndexedStack(
        index: pageIdx,
        children: pages,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            // adjust the height of DrawerHeader to 60
            const SizedBox(
              height: 60,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
            ),
            ListTile(
              title: const Text('home'),
              onTap: () => tap(0),
            ),
            ListTile(
              title: const Text('Your Vocabulary'),
              onTap: () => tap(1),
            ),
            ListTile(
              title: const Text('Built-in Vocabulary'),
              onTap: () => tap(2),
            ),
          ],
        ),
      ),
    );
  }
}