import './bloc-provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

class PushNotifBloc implements BlocBase {
  static PushNotifBloc _instance;

  PushNotifBloc.init() {
    _instance = this;
    _askPermission();
    _getFCMToken();
    _configureMessaging();
  }

  factory PushNotifBloc() {
    if (_instance == null) {
      print('WARNING: Attempted to get PushNotifBloc instance, before one was initialised.');
    }
    return _instance;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  BehaviorSubject<Map<String, dynamic>> _newMsgsController = BehaviorSubject();
  Stream<Map<String, dynamic>> get outNewMessages => _newMsgsController.stream;
  Sink<Map<String, dynamic>> get _inNewMessages => _newMsgsController.sink;

  void _askPermission() {
    _firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void _configureMessaging() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // TODO: implement in-app push notifications
        print('_firebaseMessaging.configure => onMessage \n $message');
      },
      onLaunch: _onMessage,
      onResume: _onMessage,
    );
  }

  void _getFCMToken() async {
    // TODO: implement saving FCM token somewhere
    try {
      final token = await _firebaseMessaging.getToken();
      print('FCM token - $token');
    } catch(er) {
      print('Error getting FCM token \n $er');
    }
  }

  Future<dynamic> _onMessage(Map<String, dynamic> message) async {
    // TODO: implement receiving messages function
    print(message);
    if (message['data'] != null && message['data']['type'] != null) {
        _inNewMessages.add(message);
    }
    return null;
  }

  @override
  void dispose() {
    _newMsgsController.close();
  }
}
