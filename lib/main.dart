import 'package:buddy_care/blocs/app-bloc.dart';
import 'package:buddy_care/models/post.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

void main() {
  final bcBloc = BuddyCareBLoC();
  runApp(MyApp(bloc: bcBloc));
}

class MyApp extends StatelessWidget {
  final BuddyCareBLoC bloc;
  MyApp({
    Key key,
    this.bloc,
  }): super(key: key);

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuddyCare',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Buddy Care', bloc: bloc,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.bloc}) : super(key: key);

  final BuddyCareBLoC bloc;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _buildItem(Post post) => Container(
    padding: EdgeInsets.symmetric(vertical: 10.0),
    child: Text(post.text),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: StreamBuilder<UnmodifiableListView<Post>>(
        stream: widget.bloc.posts,
        initialData: UnmodifiableListView<Post>([]),
        builder: (context, snapshot) => ListView(
          children: snapshot.data.map(_buildItem).toList(),
        )
      )
    );
  }
}
