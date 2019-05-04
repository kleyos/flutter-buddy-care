
import 'package:buddy_care/ui/home/home-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:buddy_care/blocs/app-bloc.dart';
import 'package:buddy_care/blocs/bloc-provider.dart';
import 'package:buddy_care/blocs/notif-bloc.dart';
import 'package:buddy_care/models/account-model.dart';
import 'package:buddy_care/services/prefs-service.dart';
import 'package:buddy_care/ui/login/login-screen.dart';

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
        home: RootPage(title: 'Buddy Care'),
        routes: <String, WidgetBuilder>{
          '/root': (BuildContext context) => RootPage(),
          '/home': (BuildContext context) => HomeScreen(bloc: ApplicationBloc()),
        },
      )
    );
  }
}

class _RootPageState extends State<RootPage> {
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


  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ApplicationBloc>(context);
    return Account.current != null
      ? HomeScreen(bloc: _bloc,)
      : LoginScreen();
  }
}

class RootPage extends StatefulWidget {
  RootPage({Key key, this.title }) : super(key: key);

  final String title;

  @override
  _RootPageState createState() => _RootPageState();
}

