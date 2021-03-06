import 'package:buddy_care/login/auth-state.dart';
import 'package:buddy_care/login/fb-provider.dart';
import 'package:buddy_care/models/account-model.dart';
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
  Widget build(BuildContext context) => OutlineButton.icon(
    key: Key('fb_btn'),
    label: _loading
      ? CircularProgressIndicator()
      : Text(
          'Login with FACEBOOK',
          style: TextStyle(
            fontSize: 16
          ),
        ),
    textColor: Colors.white,
    padding: const EdgeInsets.all(12.0),
    icon: Image.asset('assets/f.png', color: Colors.white, height: 30,),
    onPressed: _loading ? null : _onFBBtnTap,
    borderSide: const BorderSide(color: Colors.white, width: 2.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(26)),
    ),
  );
}

class FBButton extends StatefulWidget {
  @override
  _FBButtonState createState() => _FBButtonState();
}
