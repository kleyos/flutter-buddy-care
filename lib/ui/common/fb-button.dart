import 'package:buddy_care/login/auth-state.dart';
import 'package:buddy_care/login/fb-provider.dart';
import 'package:buddy_care/models/account-model.dart';
import 'package:buddy_care/ui/common/main-button.dart';
import 'package:flutter/material.dart';

class _FBButtonState extends State<FBButton> with FBScreenProvider {
  FBScreenPresenter _presenter;
  bool _loading = false;

  _FBButtonState() {
    _presenter = FBScreenPresenter(this);
  }
  @override
  void onActionError(String errorTxt) {
    print(errorTxt);
  }

  @override
  void onActionSuccess(Account acc) async {
    Account.current = acc;
    AuthStateProvider().notify(AuthState.LOGGED_IN);
  }

  void _onFBBtnTap() {
    setState(() {
      _loading = true;
    });
    _presenter.requestToken();
  }

  @override
  Widget build(BuildContext context) {
    return MainButton(
      key: Key('fb_btn'),
      text: 'LOGIN WITH FACEBOOK',
      bgColor: Colors.blueAccent,
      isLoading: _loading,
      onTap: _onFBBtnTap,
    );
  }
}

class FBButton extends StatefulWidget {
  @override
  _FBButtonState createState() => _FBButtonState();
}
