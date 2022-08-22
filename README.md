# Wordy

Wordy is my first app project written in flutter.
It is used to memorize English vocabularies for chinese users.

This is user's vocabulary page. User can record a new word in daily life.

- The user's vocabulary page:

![](https://i.imgur.com/0s0m1GA.png)

- The vocabulary adding page:

![](https://i.imgur.com/R91w7uj.png)

This is the detailed vocabulary page. It has "word", "part of speech", "translation", "definition", and at most 5 examples showing how to use the word.
And user can modify the info of this vocabulary.

- The detailed vocabulary page:

![](https://i.imgur.com/jjkIEk9.png)

This is the built-in vocabularies page. I will add more words with versioning.

- The built-in vocabulary page:

![](https://i.imgur.com/TSBT3m5.png)

## backend development detail
I use [sqflite](https://pub.dev/packages/sqflite) as the backend database.
The access method can be found in [/lib/module/db.dart](https://github.com/OEmiliatanO/Wordy/blob/master/lib/module/db.dart) 
And this file define two class to deal with user's data and built-in data.

Next comes to VocabDistributor which can be found in [/lib/module/vocabDistributor.dart](https://github.com/OEmiliatanO/Wordy/blob/master/lib/module/vocabDistributor.dart)

This class is meant to deal with the requests from frontend, e.g., get all the vocabularies in database, add a new vocabulary, modify a vocabulary, searching, randomly pick a vocabulary, and so on ...

It has two caches inside the VocabDistributor class to help reduce the cost of getting all vocabularies from database.

And that's all!

## frontend development detail
First, main.dart, nothing to say. The first page is [/lib/nav/nav.dart](https://github.com/OEmiliatanO/Wordy/blob/master/lib/nav/nav.dart) which is a stateful widget.

Note that this may need an improvement. A stateful widget as in root page may cause poor performance. :(

[/lib/nav/nav.dart](https://github.com/OEmiliatanO/Wordy/blob/master/lib/nav/nav.dart) contains three pages to switch:

```dart
static List<Widget> pages = <Widget>[
    const Home(),
    const UrVocab(),
    const BuiltinVocab(),
];
```

By using IndexedStack to switch. And the switch trigger is in drawer.

Then comes to [lib/pages/home.dart](https://github.com/OEmiliatanO/Wordy/blob/master/lib/pages/home.dart) . This page randomly pick a vocabulary in database to show.

Second is [lib/pages/urvocab.dart](https://github.com/OEmiliatanO/Wordy/blob/master/lib/pages/urvocab.dart) . This is the page showing all the user's vocabularies.

It's constructed by title and VocabPage (I'll talk later).

Next is [lib/pages/builtinvocab.dart](https://github.com/OEmiliatanO/Wordy/blob/master/lib/pages/builtinvocab.dart) . This is the page showing all the built-in vocabularies.

It's also constructed by title and VocabPage.


Let dig in deeper, [lib/pages/component/vocabs.dart](https://github.com/OEmiliatanO/Wordy/blob/master/lib/pages/component/vocabs.dart)

This is a component of user's vocabulary page and also built-in vocabulary page.

The middle section is a Listview containing vocabularies get from corresponding database. And in order to refresh, because of adding and modify, it's defined as stateful widget.

If tap on a vocabulary, it'll lead to a page, [lib/pages/component/vocabDetail.dart](https://github.com/OEmiliatanO/Wordy/blob/master/lib/pages/component/vocabDetail.dart)

When this page is built, the detailed pages of other vocabularies are built, since I use PageView to implement the left/right slider operation.

Note that "add" and "modify" button can be seen only when in user vocabulary page.


And later is [lib/pages/addnew.dart](https://github.com/OEmiliatanO/Wordy/blob/master/lib/pages/addnew.dart) and [lib/pages/modifypage.dart](https://github.com/OEmiliatanO/Wordy/blob/master/lib/pages/modifypage.dart)

These two are implemented by Form. When the button is pressed, they will insert a vocabulary and update a vocabulary.  

## TODO list
- The home page isn't implemented randomly pick a word from database.
- The UI need improvement.
- Haven't implement searching.
- Haven't implement delete.