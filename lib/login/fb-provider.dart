import 'package:buddy_care/models/account-model.dart';
import 'package:buddy_care/services/api/user-api.dart';
import 'package:buddy_care/services/prefs-service.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

abstract class FBScreenProvider {
  void onActionSuccess(Account acc);
  void onActionError(String errorTxt);
}

class FBScreenPresenter {
  FBScreenProvider _view;
  FBScreenPresenter(this._view);

  void requestToken() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        doLogin(result.accessToken.token);
        print(result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print(result.status);
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }


  void doLogin(token) async {
    try {
      Account user = await UserApi().requestProfile(token);
      PrefsService().storeSession(user);
      _view.onActionSuccess(user);
    } catch (e) {
      _view.onActionError(e.toString());
    }
  }
}
