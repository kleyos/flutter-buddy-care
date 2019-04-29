import 'package:buddy_care/blocs/app-bloc.dart';
import 'package:buddy_care/blocs/bloc-provider.dart';
import 'package:buddy_care/blocs/notif-bloc.dart';
import 'package:buddy_care/models/post.dart';
import 'package:buddy_care/services/prefs-service.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final prefsInstance = await SharedPreferences.getInstance();
  PrefsService.init(prefsInstance);
  PushNotifBloc.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
  }): super(key: key);

@override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: MaterialApp(
      title: 'BuddyCare',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Buddy Care'),
    )
    );}
}



class _MyHomePageState extends State<MyHomePage> {
  ApplicationBloc _bloc;

  @override
  void initState() {
    super.initState();
    PushNotifBloc().outNewMessages.listen(_onReceivePushNotification);
  }

  void _onReceivePushNotification(Map<String, dynamic> message) {
    // TODO: implement tap on Push notification
    print('---------- _onReceivePushNotification ---------- \n $message');
  }

  Widget _buildItem(Post post) =>
    Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(post.text),
    );


  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ApplicationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: StreamBuilder<UnmodifiableListView<Post>>(
        stream: _bloc.buddyCareBLoC.posts,
        initialData: UnmodifiableListView<Post>([]),
        builder: (context, snapshot) =>
          ListView(
            children: snapshot.data.map(_buildItem).toList(),
          )
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

