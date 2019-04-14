

import 'package:buddy_care/models/account-model.dart';
import 'package:buddy_care/services/prefs-service.dart';

abstract class AuthStateListener {
  void onAuthStateChanged(AuthState state);
}

class AuthStateProvider {
  static final AuthStateProvider _instance = AuthStateProvider._internal();

  List<AuthStateListener> _subscribers;

  factory AuthStateProvider() => _instance;

  AuthStateProvider._internal() {
    _subscribers = List<AuthStateListener>();
    initState();
  }

  void initState() async {
    if (Account.current != null) {
      notify(AuthState.LOGGED_IN);
    } else {
      notify(AuthState.LOGGED_OUT);
    }
  }

  Future<void> logout() async {
    if (Account.current != null) {
      Account.current = null;
      notify(AuthState.LOGGED_OUT);
      PrefsService().deleteSession();
    }
  }


  void subscribe(AuthStateListener listener) {
    _subscribers.add(listener);
  }

  void dispose(AuthStateListener listener) {
    _subscribers.remove(listener);
  }

  void notify(AuthState state) {
    _subscribers.forEach((AuthStateListener s) {
      s.onAuthStateChanged(state);
    });
  }
}

enum AuthState {
  LOGGED_IN,
  LOGGED_OUT
}
